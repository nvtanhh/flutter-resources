import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/constants/constants.index.dart';
import '../pages/auth/auth_index.dart';
import '../pages/setting/setting_index.dart';
import '../pages/todo/todo_index.dart';

part 'route.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // authentication
    AutoRoute(page: SignInWrapper, initial: true, path: RouteConstants.signIn),
    // setting
    AutoRoute(page: SettingWrapper, path: RouteConstants.setting),
    AutoRoute(page: ThemeSettingPage, path: RouteConstants.themeSetting),
    AutoRoute(page: FontSettingPage, path: RouteConstants.fontSetting),
    // todo
    AutoRoute(page: TodoWrapper, path: RouteConstants.todo),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
