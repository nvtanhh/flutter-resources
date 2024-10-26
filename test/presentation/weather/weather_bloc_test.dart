import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_resources/domain/entities/weather.dart';
import 'package:flutter_resources/presentation/pages/weather/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

Position get mockPosition => Position(
      latitude: 52.561270,
      longitude: 5.639382,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        500,
        isUtc: true,
      ),
      altitude: 3000.0,
      accuracy: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 3.0,
      headingAccuracy: 5.0,
    );

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCachedWeather mockGetCachedWeather;
  late MockGetWeatherByCityName mockGetWeatherByCityName;
  late MockGetWeatherByLocation mockGetWeatherByLocation;
  late MockGeolocatorService mockGeolocatorService;

  setUp(() {
    // init mocks
    mockGetCachedWeather = MockGetCachedWeather();
    mockGetWeatherByCityName = MockGetWeatherByCityName();
    mockGetWeatherByLocation = MockGetWeatherByLocation();
    mockGeolocatorService = MockGeolocatorService();
    weatherBloc = WeatherBloc(
      mockGetCachedWeather,
      mockGetWeatherByCityName,
      mockGetWeatherByLocation,
      mockGeolocatorService,
    );
  });
  const weather = Weather(
    cityName: 'London',
    country: 'VN',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 10,
    tempFeelLike: 10,
    humidity: 50,
    pressure: 1030,
    windSpeed: 4,
  );

  tearDown(() {
    weatherBloc.close();
  });

  group('initBloc', () {
    blocTest(
      'should emit [WeatherLoaded, WeatherRefreshing, WeatherLoaded] when data is gotten from cache && refresh weather by current location',
      build: () {
        when(mockGetCachedWeather(any))
            .thenAnswer((_) => Future.value(weather));
        when(mockGeolocatorService.getCurrentPosition())
            .thenAnswer((_) => Future.value(mockPosition));
        when(mockGetWeatherByLocation(any))
            .thenAnswer((_) => Future.value(weather));
        return weatherBloc;
      },
      act: (_) => weatherBloc.add(const WeatherInitialEvent()),
      expect: () => const [
        WeatherLoaded(weather: weather),
        WeatherRefreshing(),
        WeatherLoaded(weather: weather),
      ],
    );
    blocTest(
      'should emit [WeatherLoading, WeatherLoaded] when no data is gotten from cache && refresh weather by current location',
      build: () {
        when(mockGetCachedWeather(any)).thenAnswer((_) => Future.value());
        when(mockGeolocatorService.getCurrentPosition())
            .thenAnswer((_) => Future.value(mockPosition));
        when(mockGetWeatherByLocation(any))
            .thenAnswer((_) => Future.value(weather));
        return weatherBloc;
      },
      act: (_) => weatherBloc.add(const WeatherInitialEvent()),
      expect: () => const [
        WeatherLoading(),
        WeatherLoaded(weather: weather),
      ],
    );
  });

  group('getWeatherByCityName', () {
    blocTest(
      'should emit [WeatherRefreshing, WeatherLoaded] when get weather by city name',
      build: () {
        when(mockGetWeatherByCityName(any))
            .thenAnswer((_) => Future.value(weather));
        return weatherBloc;
      },
      act: (_) => weatherBloc.add(const GetWeatherByCityNameEvent('London')),
      expect: () => const [
        WeatherRefreshing(),
        WeatherLoaded(weather: weather),
      ],
    );
  });
}
