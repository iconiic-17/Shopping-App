import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/details/domain/entities/product_details_entity.dart';
import 'package:shopping_app/features/details/domain/repo/product_details_data_source_interface.dart';
import 'package:shopping_app/features/details/domain/repo/product_details_repo_interface.dart';

@Injectable(as: ProductDetailsRepoInterface)
class ProductDetailsRepoImp implements ProductDetailsRepoInterface {
  final ProductDetailsDataSourceInterface _dataSource;
  ProductDetailsRepoImp(this._dataSource);

  @override
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int id) =>
      _dataSource.getProductDetails(id);
}
