// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shopping_app/features/details/data/api/product_details_api_imp.dart'
    as _i954;
import 'package:shopping_app/features/details/data/api/product_details_api_interface.dart'
    as _i398;
import 'package:shopping_app/features/details/data/repo/product_details_data_source_imp.dart'
    as _i830;
import 'package:shopping_app/features/details/data/repo/product_details_repo_imp.dart'
    as _i283;
import 'package:shopping_app/features/details/domain/repo/product_details_data_source_interface.dart'
    as _i6;
import 'package:shopping_app/features/details/domain/repo/product_details_repo_interface.dart'
    as _i607;
import 'package:shopping_app/features/details/domain/use_case/get_product_details_use_case.dart'
    as _i343;
import 'package:shopping_app/features/details/presentation/view_model/product_details_cubit.dart'
    as _i225;
import 'package:shopping_app/features/home/data/api/home_api_imp.dart' as _i27;
import 'package:shopping_app/features/home/data/api/home_api_interface.dart'
    as _i824;
import 'package:shopping_app/features/home/data/repo/home_data_source_imp.dart'
    as _i797;
import 'package:shopping_app/features/home/data/repo/home_repo_imp.dart'
    as _i529;
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart'
    as _i879;
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart'
    as _i191;
import 'package:shopping_app/features/home/domain/use_case/get_all_categories_use_case.dart'
    as _i634;
import 'package:shopping_app/features/home/domain/use_case/get_all_products_use_case.dart'
    as _i219;
import 'package:shopping_app/features/home/domain/use_case/get_products_by_category_use_case.dart'
    as _i32;
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart'
    as _i991;
import 'package:shopping_app/features/home/presentation/view_model/products_by_category_cubit.dart'
    as _i395;
import 'package:shopping_app/features/search/data/api/search_api_imp.dart'
    as _i0;
import 'package:shopping_app/features/search/data/api/search_api_interface.dart'
    as _i209;
import 'package:shopping_app/features/search/data/repo/search_data_source_imp.dart'
    as _i57;
import 'package:shopping_app/features/search/data/repo/search_repo_imp.dart'
    as _i864;
import 'package:shopping_app/features/search/domain/repo/search_data_source_interface.dart'
    as _i1024;
import 'package:shopping_app/features/search/domain/repo/search_repo_interface.dart'
    as _i708;
import 'package:shopping_app/features/search/domain/use_case/search_products_use_case.dart'
    as _i818;
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart'
    as _i862;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i398.ProductDetailsApiInterface>(
      () => _i954.ProductDetailsApiImp(),
    );
    gh.factory<_i824.HomeApiInterface>(() => _i27.HomeApiImp());
    gh.factory<_i209.SearchApiInterface>(() => _i0.SearchApiImp());
    gh.factory<_i879.HomeDataSourceInterface>(
      () => _i797.HomeDataSourceImp(gh<_i824.HomeApiInterface>()),
    );
    gh.factory<_i6.ProductDetailsDataSourceInterface>(
      () => _i830.ProductDetailsDataSourceImp(
        gh<_i398.ProductDetailsApiInterface>(),
      ),
    );
    gh.factory<_i607.ProductDetailsRepoInterface>(
      () => _i283.ProductDetailsRepoImp(
        gh<_i6.ProductDetailsDataSourceInterface>(),
      ),
    );
    gh.factory<_i1024.SearchDataSourceInterface>(
      () => _i57.SearchDataSourceImp(gh<_i209.SearchApiInterface>()),
    );
    gh.factory<_i191.HomeRepoInterface>(
      () => _i529.HomeRepoImp(gh<_i879.HomeDataSourceInterface>()),
    );
    gh.factory<_i343.GetProductDetailsUseCase>(
      () => _i343.GetProductDetailsUseCase(
        gh<_i607.ProductDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i225.ProductDetailsCubit>(
      () => _i225.ProductDetailsCubit(gh<_i343.GetProductDetailsUseCase>()),
    );
    gh.factory<_i634.GetAllCategoriesUseCase>(
      () => _i634.GetAllCategoriesUseCase(gh<_i191.HomeRepoInterface>()),
    );
    gh.factory<_i219.GetAllProductsUseCase>(
      () => _i219.GetAllProductsUseCase(gh<_i191.HomeRepoInterface>()),
    );
    gh.factory<_i32.GetProductsByCategoryUseCase>(
      () => _i32.GetProductsByCategoryUseCase(gh<_i191.HomeRepoInterface>()),
    );
    gh.factory<_i708.SearchRepoInterface>(
      () => _i864.SearchRepoImp(gh<_i1024.SearchDataSourceInterface>()),
    );
    gh.factory<_i395.ProductsByCategoryCubit>(
      () => _i395.ProductsByCategoryCubit(
        gh<_i32.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i818.SearchProductsUseCase>(
      () => _i818.SearchProductsUseCase(gh<_i708.SearchRepoInterface>()),
    );
    gh.factory<_i991.HomeCubit>(
      () => _i991.HomeCubit(
        gh<_i219.GetAllProductsUseCase>(),
        gh<_i634.GetAllCategoriesUseCase>(),
      ),
    );
    gh.factory<_i862.SearchCubit>(
      () => _i862.SearchCubit(gh<_i818.SearchProductsUseCase>()),
    );
    return this;
  }
}
