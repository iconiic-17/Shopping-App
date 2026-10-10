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
import 'package:shopping_app/features/home/domain/use_case/get_all_products_use_case.dart'
    as _i219;
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart'
    as _i991;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i824.HomeApiInterface>(() => _i27.HomeApiImp());
    gh.factory<_i879.HomeDataSourceInterface>(
      () => _i797.HomeDataSourceImp(gh<_i824.HomeApiInterface>()),
    );
    gh.factory<_i191.HomeRepoInterface>(
      () => _i529.HomeRepoImp(gh<_i879.HomeDataSourceInterface>()),
    );
    gh.factory<_i219.GetAllProductsUseCase>(
      () => _i219.GetAllProductsUseCase(gh<_i191.HomeRepoInterface>()),
    );
    gh.factory<_i991.HomeCubit>(
      () => _i991.HomeCubit(gh<_i219.GetAllProductsUseCase>()),
    );
    return this;
  }
}
