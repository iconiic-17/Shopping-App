import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetAllProductsUseCase {
  final HomeRepoInterface _repo;
  GetAllProductsUseCase(this._repo);

  Future<ResultApi<ProductResponseEntity>> invoke() async =>
      await _repo.getAllProducts();
}
