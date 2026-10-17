import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/domain/repo/product_details_repo_interface.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductDetailsRepoInterface _repo;
  GetProductDetailsUseCase(this._repo);

  Future<ResultApi<ProductDetailsEntity>> invoke(int id) =>
      _repo.getProductDetails(id);
}
