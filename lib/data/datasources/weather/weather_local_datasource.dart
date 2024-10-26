import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configs/injector/injection.dart';
import '../../../core/constants/storage_constants.dart';
import '../../models/weather_model.dart';

abstract class WeatherLocalDatasource {
  /// Get cached [WeatherModel] which was previously saved.
  Future<WeatherModel?> getWeather();

  /// Store [WeatherModel] to cache.
  Future<void> cacheWeather(WeatherModel weather);
}

@Injectable(as: WeatherLocalDatasource)
class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  final SharedPreferences _preferencesStorage;

  WeatherLocalDatasourceImpl(this._preferencesStorage);

  @override
  Future<WeatherModel?> getWeather() async {
    try {
      final storedData =
          _preferencesStorage.getString(StorageConstants.weather);
      if (storedData == null) return null;
      return WeatherModel.fromJson(
        jsonDecode(storedData) as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      getIt<Logger>().e(
        'WeatherLocalDatasourceImpl - getWeather',
        error: e,
        stackTrace: stackTrace,
      );
      _preferencesStorage.remove(StorageConstants.weather);
      return null;
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    _preferencesStorage.setString(
      StorageConstants.weather,
      jsonEncode(
        WeatherModel.fromEntity(weather).toJson(),
      ),
    );
  }
}
