// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shopping_app/core/di/register_module.dart' as _i524;
import 'package:shopping_app/core/helper/flutter_secure_storage.dart' as _i626;
import 'package:shopping_app/core/network/dio_module.dart' as _i676;
import 'package:shopping_app/features/auth/data/api/auth_api.dart' as _i870;
import 'package:shopping_app/features/auth/data/repo/auth_data_source_impl.dart'
    as _i590;
import 'package:shopping_app/features/auth/data/repo/auth_repo_impl.dart'
    as _i741;
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart'
    as _i945;
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart'
    as _i247;
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart'
    as _i768;
import 'package:shopping_app/features/auth/domain/use_case/register_use_case.dart'
    as _i817;
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart'
    as _i346;
import 'package:shopping_app/features/auth/presentation/view_model/register/register_cubit.dart'
    as _i82;
import 'package:shopping_app/features/cart/data/repo/cart_data_source_imp.dart'
    as _i69;
import 'package:shopping_app/features/cart/data/repo/cart_repo_imp.dart'
    as _i1035;
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart'
    as _i752;
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart'
    as _i783;
import 'package:shopping_app/features/cart/domain/use_case/get_item_use_case.dart'
    as _i345;
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart'
    as _i824;
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
import 'package:shopping_app/features/favourite/data/repo/favourite_data_source_imp.dart'
    as _i708;
import 'package:shopping_app/features/favourite/data/repo/favourite_repo_imp.dart'
    as _i1073;
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart'
    as _i267;
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart'
    as _i563;
import 'package:shopping_app/features/favourite/domain/use_case/get_item_use_case.dart'
    as _i413;
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart'
    as _i443;
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
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i626.AppSecureStorage>(
      () => _i626.AppSecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i209.SearchApiInterface>(
      () => _i0.SearchApiImp(gh<_i626.AppSecureStorage>()),
    );
    gh.factory<_i824.HomeApiInterface>(
      () => _i27.HomeApiImp(gh<_i626.AppSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i626.AppSecureStorage>()),
    );
    gh.factory<_i870.AuthApi>(
      () => _i870.AuthApi(gh<_i626.AppSecureStorage>()),
    );
    gh.factory<_i398.ProductDetailsApiInterface>(
      () => _i954.ProductDetailsApiImp(gh<_i626.AppSecureStorage>()),
    );
    gh.factory<_i945.AuthDataSourceInterface>(
      () => _i590.AuthDataSourceImpl(gh<_i870.AuthApi>()),
    );
    gh.factory<_i1024.SearchDataSourceInterface>(
      () => _i57.SearchDataSourceImp(gh<_i209.SearchApiInterface>()),
    );
    gh.factory<_i267.FavouriteDataSourceInterface>(
      () => _i708.FavouriteDataSourceImp(gh<_i361.Dio>()),
    );
    gh.factory<_i752.CartDataSourceInterface>(
      () => _i69.CartDataSourceImp(gh<_i361.Dio>()),
    );
    gh.factory<_i879.HomeDataSourceInterface>(
      () => _i797.HomeDataSourceImp(gh<_i824.HomeApiInterface>()),
    );
    gh.factory<_i6.ProductDetailsDataSourceInterface>(
      () => _i830.ProductDetailsDataSourceImp(
        gh<_i398.ProductDetailsApiInterface>(),
      ),
    );
    gh.factory<_i783.CartRepoInterface>(
      () => _i1035.CartRepoImp(gh<_i752.CartDataSourceInterface>()),
    );
    gh.factory<_i563.FavouriteRepoInterface>(
      () => _i1073.FavouriteRepoImp(gh<_i267.FavouriteDataSourceInterface>()),
    );
    gh.factory<_i247.AuthRepoInterface>(
      () => _i741.AuthRepoImpl(gh<_i945.AuthDataSourceInterface>()),
    );
    gh.factory<_i607.ProductDetailsRepoInterface>(
      () => _i283.ProductDetailsRepoImp(
        gh<_i6.ProductDetailsDataSourceInterface>(),
      ),
    );
    gh.factory<_i413.GetFavouritesUseCase>(
      () => _i413.GetFavouritesUseCase(gh<_i563.FavouriteRepoInterface>()),
    );
    gh.factory<_i413.AddFavouriteUseCase>(
      () => _i413.AddFavouriteUseCase(gh<_i563.FavouriteRepoInterface>()),
    );
    gh.factory<_i413.DeleteFavouriteUseCase>(
      () => _i413.DeleteFavouriteUseCase(gh<_i563.FavouriteRepoInterface>()),
    );
    gh.factory<_i768.LoginUseCase>(
      () => _i768.LoginUseCase(gh<_i247.AuthRepoInterface>()),
    );
    gh.factory<_i817.RegisterUseCase>(
      () => _i817.RegisterUseCase(gh<_i247.AuthRepoInterface>()),
    );
    gh.factory<_i346.LoginCubit>(
      () => _i346.LoginCubit(gh<_i768.LoginUseCase>()),
    );
    gh.factory<_i708.SearchRepoInterface>(
      () => _i864.SearchRepoImp(gh<_i1024.SearchDataSourceInterface>()),
    );
    gh.lazySingleton<_i443.FavouriteCubit>(
      () => _i443.FavouriteCubit(
        gh<_i413.GetFavouritesUseCase>(),
        gh<_i413.AddFavouriteUseCase>(),
        gh<_i413.DeleteFavouriteUseCase>(),
      ),
    );
    gh.factory<_i191.HomeRepoInterface>(
      () => _i529.HomeRepoImp(gh<_i879.HomeDataSourceInterface>()),
    );
    gh.factory<_i345.GetCartUseCase>(
      () => _i345.GetCartUseCase(gh<_i783.CartRepoInterface>()),
    );
    gh.factory<_i345.AddCartUseCase>(
      () => _i345.AddCartUseCase(gh<_i783.CartRepoInterface>()),
    );
    gh.factory<_i345.DeleteCartUseCase>(
      () => _i345.DeleteCartUseCase(gh<_i783.CartRepoInterface>()),
    );
    gh.factory<_i818.SearchProductsUseCase>(
      () => _i818.SearchProductsUseCase(gh<_i708.SearchRepoInterface>()),
    );
    gh.factory<_i343.GetProductDetailsUseCase>(
      () => _i343.GetProductDetailsUseCase(
        gh<_i607.ProductDetailsRepoInterface>(),
      ),
    );
    gh.lazySingleton<_i824.CartCubit>(
      () => _i824.CartCubit(
        gh<_i345.GetCartUseCase>(),
        gh<_i345.AddCartUseCase>(),
        gh<_i345.DeleteCartUseCase>(),
      ),
    );
    gh.factory<_i82.RegisterCubit>(
      () => _i82.RegisterCubit(gh<_i817.RegisterUseCase>()),
    );
    gh.factory<_i862.SearchCubit>(
      () => _i862.SearchCubit(gh<_i818.SearchProductsUseCase>()),
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
    gh.factory<_i395.ProductsByCategoryCubit>(
      () => _i395.ProductsByCategoryCubit(
        gh<_i32.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i991.HomeCubit>(
      () => _i991.HomeCubit(
        gh<_i219.GetAllProductsUseCase>(),
        gh<_i634.GetAllCategoriesUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i524.RegisterModule {}

class _$NetworkModule extends _i676.NetworkModule {}
