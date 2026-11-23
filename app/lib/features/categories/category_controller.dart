import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/grpc/grpc_providers.dart';
import '../../core/storage/snapshot.dart';
import '../../core/storage/snapshot_codecs.dart';
import '../auth/auth_controller.dart';
import 'category_api.dart';
import 'category_models.dart';

final categoryApiProvider = Provider<CategoryApi>(
  (ref) => GrpcCategoryApi(ref.watch(grpcChannelProvider)),
);

final categoriesControllerProvider =
    AsyncNotifierProvider<CategoriesController, List<Category>>(
      CategoriesController.new,
      retry: (_, _) => null,
    );

/// This month's budgets (Shamsi month) with what has been spent.
final budgetsProvider = FutureProvider<List<BudgetRow>>((ref) {
  final window = shamsiMonthWindow(DateTime.now());
  return ref
      .read(authControllerProvider.notifier)
      .withAccess(
        (access) => ref
            .read(categoryApiProvider)
            .budgets(access, start: window.start, end: window.end),
      );
});

class CategoriesController extends AsyncNotifier<List<Category>> {
  CategoryApi get _api => ref.read(categoryApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<List<Category>> build() => withSnapshot(
    ref,
    'categories',
    load: () => _auth.withAccess(_api.list),
    encode: categoriesToJson,
    decode: categoriesFromJson,
  );

  Future<void> create(String name, CategoryKind kind) async {
    await _auth.withAccess((a) => _api.create(a, name: name, kind: kind));
    await _reload();
  }

  Future<void> delete(String categoryId) async {
    await _auth.withAccess((a) => _api.delete(a, categoryId));
    await _reload();
    ref.invalidate(budgetsProvider);
  }

  Future<void> setBudget(
    String categoryId,
    String currency,
    int limitMinor,
  ) async {
    await _auth.withAccess(
      (a) => _api.setBudget(
        a,
        categoryId: categoryId,
        currency: currency,
        limitMinor: limitMinor,
      ),
    );
    ref.invalidate(budgetsProvider);
  }

  Future<void> _reload() async {
    state = AsyncData(await _auth.withAccess(_api.list));
  }
}
