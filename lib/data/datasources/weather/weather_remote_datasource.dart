import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../configs/app_config.dart';
import '../../../core/exceptions/exceptions.index.dart';
import '../../models/weather_model.dart';

abstract class WeatherRemoteDatasource {
  /// Get [WeatherModel] from API by city name.
  Future<WeatherModel> getWeatherByCityName(
    String cityName, {
    String? language,
  });

  /// Get [WeatherModel] from API by location.
  Future<WeatherModel> getWeatherByLocation(
    double lat,
    double lon, {
    String? language,
  });
}

@Injectable(as: WeatherRemoteDatasource)
class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Client client;

  WeatherRemoteDatasourceImpl(this.client);

  @override
  Future<WeatherModel> getWeatherByCityName(
    String cityName, {
    String? language,
  }) async {
    language ??= 'en';
    final response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&lang=$language&units=metric&appid=${AppConfig.kApiKey}',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException(
        code: response.statusCode,
        message: jsonDecode(response.body)['message'] as String,
      );
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation(
    double lat,
    double lon, {
    String? language,
  }) async {
    language ??= Platform.localeName;
    final response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=$language&units=metric&appid=${AppConfig.kApiKey}',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException(
        code: response.statusCode,
        message: jsonDecode(response.body)['message'] as String,
      );
    }
  }
}
