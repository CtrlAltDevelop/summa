import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:grpc/grpc.dart';

import '../../gen/apps/wallets/grpc/wallets.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'category_models.dart';

abstract interface class CategoryApi {
  Future<List<Category>> list(String access);
  Future<Category> create(
    String access, {
    required String name,
    required CategoryKind kind,
  });
  Future<void> delete(String access, String categoryId);

  /// A [limitMinor] of zero removes the budget.
  Future<void> setBudget(
    String access, {
    required String categoryId,
    required String currency,
    required int limitMinor,
  });
  Future<List<BudgetRow>> budgets(
    String access, {
    required DateTime start,
    required DateTime end,
  });
}

class GrpcCategoryApi implements CategoryApi {
  GrpcCategoryApi(ClientChannel channel)
    : _client = pb.CategoryControllerClient(channel);

  final pb.CategoryControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  static Category _category(pb.Category c) => Category(
    id: c.id,
    name: c.name,
    kind: CategoryKind.fromWire(c.kind),
    isOther: c.isOther,
  );

  @override
  Future<List<Category>> list(String access) => guardGrpc(() async {
    final r = await _client.list(Empty(), options: _bearer(access));
    return r.categories.map(_category).toList();
  });

  @override
  Future<Category> create(
    String access, {
    required String name,
    required CategoryKind kind,
  }) => guardGrpc(() async {
    final r = await _client.create(
      pb.CategoryCreate(name: name, kind: kind.wire),
      options: _bearer(access),
    );
    return _category(r.category);
  });

  @override
  Future<void> delete(String access, String categoryId) => guardGrpc(() async {
    await _client.delete(
      pb.CategoryRef(categoryId: categoryId),
      options: _bearer(access),
    );
  });

  @override
  Future<void> setBudget(
    String access, {
    required String categoryId,
    required String currency,
    required int limitMinor,
  }) => guardGrpc(() async {
    await _client.setBudget(
      pb.BudgetSet(
        categoryId: categoryId,
        currency: currency,
        limitMinor: Int64(limitMinor),
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<List<BudgetRow>> budgets(
    String access, {
    required DateTime start,
    required DateTime end,
  }) => guardGrpc(() async {
    final r = await _client.budgetStatus(
      pb.BudgetWindow(
        startsAt: start.toUtc().toIso8601String(),
        endsAt: end.toUtc().toIso8601String(),
      ),
      options: _bearer(access),
    );
    return r.budgets
        .map(
          (b) => BudgetRow(
            categoryId: b.categoryId,
            categoryName: b.categoryName,
            currency: b.currency,
            limitMinor: b.limitMinor.toInt(),
            spentMinor: b.spentMinor.toInt(),
          ),
        )
        .toList();
  });
}
