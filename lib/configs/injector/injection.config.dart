// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_resources/configs/injector/register.module.dart'
    as _i797;
import 'package:flutter_resources/data/datasources/weather/weather_local_datasource.dart'
    as _i1009;
import 'package:flutter_resources/data/datasources/weather/weather_remote_datasource.dart'
    as _i918;
import 'package:flutter_resources/data/repositories/weather_repository_impl.dart'
    as _i986;
import 'package:flutter_resources/domain/repositories/weather_repository.dart'
    as _i871;
import 'package:flutter_resources/domain/usecases/weather/get_cached_weather.dart'
    as _i282;
import 'package:flutter_resources/domain/usecases/weather/get_weather_by_city_name.dart'
    as _i372;
import 'package:flutter_resources/domain/usecases/weather/get_weather_by_location.dart'
    as _i204;
import 'package:flutter_resources/presentation/pages/weather/bloc/weather_bloc.dart'
    as _i317;
import 'package:flutter_resources/presentation/route/route.dart' as _i410;
import 'package:flutter_resources/presentation/shared_blocs/language/language_cubit.dart'
    as _i365;
import 'package:flutter_resources/presentation/shared_blocs/theme/theme_cubit.dart'
    as _i832;
import 'package:flutter_resources/presentation/shared_blocs/user/user_cubit.dart'
    as _i265;
import 'package:flutter_resources/services/firebase_service.dart' as _i802;
import 'package:flutter_resources/services/geolocator_service.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i802.FirebaseService>(
      () => registerModule.fireService,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.preferencesStorage,
      preResolve: true,
    );
    gh.singleton<_i974.Logger>(() => registerModule.logger);
    gh.singleton<_i410.AppRouter>(() => registerModule.appRouter);
    gh.singleton<_i519.Client>(() => registerModule.client);
    gh.singleton<_i365.LanguageCubit>(() => _i365.LanguageCubit());
    gh.singleton<_i265.UserCubit>(() => _i265.UserCubit());
    gh.singleton<_i832.ThemeCubit>(() => _i832.ThemeCubit());
    gh.singleton<_i59.GeolocatorService>(() => _i59.GeolocatorService());
    gh.factory<_i918.WeatherRemoteDatasource>(
        () => _i918.WeatherRemoteDatasourceImpl(gh<_i519.Client>()));
    gh.factory<_i1009.WeatherLocalDatasource>(
        () => _i1009.WeatherLocalDatasourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i871.WeatherRepository>(() => _i986.WeatherRepositoryImpl(
          gh<_i918.WeatherRemoteDatasource>(),
          gh<_i1009.WeatherLocalDatasource>(),
        ));
    gh.factory<_i204.GetWeatherByLocation>(
        () => _i204.GetWeatherByLocation(gh<_i871.WeatherRepository>()));
    gh.factory<_i372.GetWeatherByCityName>(
        () => _i372.GetWeatherByCityName(gh<_i871.WeatherRepository>()));
    gh.factory<_i282.GetCachedWeather>(
        () => _i282.GetCachedWeather(gh<_i871.WeatherRepository>()));
    gh.lazySingleton<_i317.WeatherBloc>(() => _i317.WeatherBloc(
          gh<_i282.GetCachedWeather>(),
          gh<_i372.GetWeatherByCityName>(),
          gh<_i204.GetWeatherByLocation>(),
          gh<_i59.GeolocatorService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i797.RegisterModule {}
