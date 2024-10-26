import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../configs/injector/injection.dart';

@singleton
class GeolocatorService {
  final defaultPosition = Position(
    latitude: 10.762622,
    longitude: 106.660172,
    timestamp: DateTime.fromMillisecondsSinceEpoch(500),
    altitude: 5.0,
    accuracy: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 3.0,
    headingAccuracy: 5.0,
  );
  Future<Position> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      getIt<Logger>().e(e.toString());
      return defaultPosition;
    }
  }
}
