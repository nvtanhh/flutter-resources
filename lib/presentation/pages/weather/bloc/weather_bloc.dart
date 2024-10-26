import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../configs/configs.index.dart';
import '../../../../core/exceptions/exceptions.index.dart';
import '../../../../core/exceptions/weather_error.dart';
import '../../../../core/params/no_params.dart';
import '../../../../core/params/weather/get_weather_by_city_name_params.dart';
import '../../../../core/params/weather/get_weather_by_location_params.dart';
import '../../../../domain/entities/weather.dart';
import '../../../../domain/usecases/weather/get_cached_weather.dart';
import '../../../../domain/usecases/weather/get_weather_by_city_name.dart';
import '../../../../domain/usecases/weather/get_weather_by_location.dart';
import '../../../../services/geolocator_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// WeatherBloc cases
/// 1. initBloc
///   a. get cached weather
///   b. Load weather by current location
///
/// 2. Load weather by city name (search)

@lazySingleton
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCachedWeather getCachedWeather;
  final GetWeatherByCityName getWeatherByCityName;
  final GetWeatherByLocation getWeatherByLocation;
  final GeolocatorService geolocatorService;

  WeatherBloc(
    this.getCachedWeather,
    this.getWeatherByCityName,
    this.getWeatherByLocation,
    this.geolocatorService,
  ) : super(WeatherInitial()) {
    on<WeatherInitialEvent>(_initWeatherBloc);
    on<GetWeatherByCityNameEvent>(_getWeatherByCityName);
    on<RefreshWeather>(_refreshWeather);
  }

  DateTime? lastRefreshTime;
  final int limitRefreshTimeSecond = 60;

  FutureOr<void> _initWeatherBloc(
    WeatherInitialEvent event,
    Emitter<WeatherState> emit,
  ) async {
    // get cached weather -> if not null, emit WeatherLoaded
    try {
      final cachedWeather = await getCachedWeather(NoParams());
      if (cachedWeather != null) {
        emit(WeatherLoaded(weather: cachedWeather));
        emit(WeatherRefreshing(weather: cachedWeather));
      } else {
        emit(const WeatherLoading());
      }
      // refreshing weather by current location
      final Position position = await geolocatorService.getCurrentPosition();
      final weather = await getWeatherByLocation(
        GetWeatherByLocationParams(
          position.latitude,
          position.longitude,
          language: event.language,
        ),
      );
      emit(WeatherLoaded(weather: weather));
    } catch (e, stackTrace) {
      getIt<Logger>().e(
        '[WeatherBloc - _initWeatherBloc]',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<FutureOr<void>> _getWeatherByCityName(
    GetWeatherByCityNameEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherRefreshing(weather: state.weather));
    try {
      final weather = await getWeatherByCityName(
        GetWeatherByCityNameParams(event.cityName, language: event.language),
      );
      emit(WeatherLoaded(weather: weather));
    } on ServerException catch (e) {
      WeatherError? error;
      if (e.isNotFound) {
        error = CityNotFoundError(e.message);
      }
      emit(
        WeatherErrorState(
          error: error,
          weather: state.weather,
        ),
      );
    } catch (e, stackTrace) {
      getIt<Logger>().e(
        '[WeatherBloc - _getWeatherByCityName]',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  FutureOr<void> _refreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) {
    if (DateTime.now().difference(lastRefreshTime ?? DateTime.now()).inSeconds <
        limitRefreshTimeSecond) {
      return Future.value();
    }
    lastRefreshTime = DateTime.now();
    if (state.weather != null) {
      add(
        GetWeatherByCityNameEvent(
          state.weather!.cityName,
          language: event.language,
        ),
      );
    } else {
      add(
        WeatherInitialEvent(language: event.language),
      );
    }
  }
}
