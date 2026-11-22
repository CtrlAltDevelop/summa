# Summa

اپ حسابداری شخصی (خرج، قسط، دارایی) برای بازار ایران؛ فارسی، چند ارز، ثبت از روی پیامک بانک.
مستندات (فارسی): [docs/README.md](docs/README.md). قواعد کار: [AGENTS.md](AGENTS.md).

```
app/       Flutter (اندروید، iOS، macOS)
backend/   Django + gRPC (از django-ninja-starter)
deploy/    docker compose برای Postgres و Redis
docs/      مستندات و فازها
```

## شروع سریع

```bash
make setup      # venv بک‌اند + وابستگی‌ها + flutter pub get
make run-lite   # بدون Docker: migrate + REST (:8010) + gRPC (:50051)
make macos      # اپ روی macOS (در ترمینال دیگر)
make check      # lint، type، migration، proto، format، analyze
make test       # pytest + flutter test
```

ابزار قرارداد: `brew install protobuf buf` و `dart pub global activate protoc_plugin`.
