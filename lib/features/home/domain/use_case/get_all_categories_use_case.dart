import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetAllCategoriesUseCase {
  final HomeRepoInterface _repo;
  GetAllCategoriesUseCase(this._repo);

  Future<ResultApi<List<CategoryItemEntity>>> invoke() async =>
      await _repo.getAllCategories();
}
