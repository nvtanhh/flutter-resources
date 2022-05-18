import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/firebase_service.dart';
import '../route/route.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

  @preResolve
  Future<SharedPreferences> get preferencesStorage =>
      SharedPreferences.getInstance();

  @singleton
  Logger get logger => Logger();

  @singleton
  AppRouter get appRouter => AppRouter();
}
