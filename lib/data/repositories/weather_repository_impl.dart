import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../configs/injector/injection.dart';
import '../../core/exceptions/exceptions.index.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather/weather_local_datasource.dart';
import '../datasources/weather/weather_remote_datasource.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;
  final WeatherLocalDatasource localDatasource;

  WeatherRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
  );

  @override
  Future<Weather?> getCachedWeather() {
    return localDatasource.getWeather();
  }

  @override
  Future<Weather> getWeatherByCityName(
    String cityName, {
    String? language,
  }) async {
    try {
      final weather = await remoteDatasource.getWeatherByCityName(
        cityName,
        language: language,
      );
      localDatasource.cacheWeather(weather);
      return weather;
    } on ServerException catch (e, stackTrace) {
      getIt<Logger>().e(
        'ServerException',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<Weather> getWeatherByLocation(
    double lat,
    double lon, {
    String? language,
  }) async {
    try {
      final weather = await remoteDatasource.getWeatherByLocation(
        lat,
        lon,
        language: language,
      );
      localDatasource.cacheWeather(weather);
      return weather;
    } on ServerException catch (e, stackTrace) {
      getIt<Logger>().e(
        'ServerException',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
