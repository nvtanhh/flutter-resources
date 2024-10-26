import 'package:auto_route/auto_route.dart';

import '../../core/constants/route_constants.dart';
import 'guards/auth_guard.dart';
import 'route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // authentication
        AutoRoute(
          page: SignInWrapperRoute.page,
          path: RouteConstants.signIn,
          keepHistory: false,
        ),
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: RouteConstants.home,
          guards: [AuthGuard()],
        ),
        // setting
        AutoRoute(
          page: LanguageSettingRoute.page,
          path: RouteConstants.languageSetting,
        ),
        AutoRoute(page: SettingWrapperRoute.page, path: RouteConstants.setting),
        AutoRoute(
          page: ThemeColorSettingRoute.page,
          path: RouteConstants.themeSetting,
        ),
        AutoRoute(
          page: FontSettingRoute.page,
          path: RouteConstants.fontSetting,
        ),
        // weather
        AutoRoute(page: WeatherWrapperRoute.page, path: RouteConstants.weather),
      ];
}
