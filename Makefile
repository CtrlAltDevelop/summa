SHELL := /bin/bash
.PHONY: setup dev down serve grpc migrate run-lite macos proto proto-lint check test

PATH := $(PATH):$(HOME)/.pub-cache/bin
VENV := $(CURDIR)/backend/.venv/bin
# Dev-only settings: SQLite and in-memory stores, so no Docker is needed.
LITE_ENV := DJANGO_SETTINGS_MODULE=config.settings.development \
	DJANGO_DB_ENGINE=django.db.backends.sqlite3 DJANGO_DB_NAME=db.sqlite3 \
	DJANGO_AUTH_CHALLENGE_STORE=infrastructure.auth.core.challenges.LocMemChallengeStore

# Every optional app on, so checks see the whole project, not just what .env enables.
ALL_APPS := DJANGO_CMS_ENABLED=true DJANGO_NOTIFICATIONS_ENABLED=true DJANGO_SHOP_ENABLED=true DJANGO_SUPPORT_ENABLED=true DJANGO_WALLET_ENABLED=true DJANGO_CLUB_ENABLED=true

# Dart stubs are generated for these protos (paths under backend/src). Add new ones here.
DART_PROTOS := infrastructure/common/grpc/common.proto \
	infrastructure/accounts/grpc/accounts.proto \
	apps/wallets/grpc/wallets.proto \
	apps/assistant/grpc/assistant.proto \
	apps/recurring/grpc/recurring.proto \
	apps/debts/grpc/debts.proto \
	apps/assets/grpc/assets.proto \
	apps/networth/grpc/networth.proto \
	apps/reports/grpc/reports.proto \
	apps/sync/grpc/sync.proto \
	apps/billing/grpc/billing.proto \
	apps/support/grpc/support.proto \
	infrastructure/auth/sms_code/grpc/auth_sms_code.proto \
	infrastructure/oauth/rotation/grpc/oauth_rotation.proto

# One-time setup on a clean clone. Contract tooling is installed separately:
#   brew install protobuf buf && dart pub global activate protoc_plugin
setup:
	cd backend && uv venv .venv && uv pip install -p .venv/bin/python -e '.[dev,asgi,redis]'
	cp -n backend/.env.example backend/.env || true
	cd app && flutter pub get

dev:
	docker compose -f deploy/docker-compose.yml up -d

down:
	docker compose -f deploy/docker-compose.yml down

migrate:
	cd backend && $(LITE_ENV) $(VENV)/python manage.py migrate

serve:
	cd backend && $(LITE_ENV) $(VENV)/python -m uvicorn config.asgi:application --reload --app-dir src --port 8010

grpc:
	cd backend && $(LITE_ENV) $(VENV)/python manage.py grpcrunaioserver

# No Docker: migrate, then REST (:8010) and gRPC (:50051) together; Ctrl-C stops both.
run-lite: migrate
	cd backend && trap 'kill 0' INT TERM EXIT; \
	$(LITE_ENV) $(VENV)/python -m uvicorn config.asgi:application --app-dir src --port 8010 & \
	$(LITE_ENV) $(VENV)/python manage.py grpcrunaioserver & \
	wait

macos:
	cd app && flutter run -d macos

# Rewrite the Python protos/stubs from the gRPC services, then the Dart stubs.
proto:
	cd backend && $(ALL_APPS) $(VENV)/python manage.py protos
	rm -rf app/lib/gen && mkdir -p app/lib/gen
	protoc --dart_out=grpc:app/lib/gen -I backend/src $(DART_PROTOS:%=backend/src/%)

proto-lint:
	buf lint

check:
	cd backend && $(VENV)/ruff check --no-cache . && $(VENV)/ruff format --check --no-cache .
	cd backend && $(VENV)/mypy src manage.py
	cd backend && $(ALL_APPS) $(VENV)/python manage.py check && $(ALL_APPS) $(VENV)/python manage.py makemigrations --check --dry-run
	cd backend && $(ALL_APPS) $(VENV)/python manage.py protos --check
	buf lint
	cd app && dart format --output=none --set-exit-if-changed lib test
	cd app && flutter analyze --no-fatal-infos

test:
	cd backend && $(VENV)/pytest --cov
	cd app && flutter test --coverage
