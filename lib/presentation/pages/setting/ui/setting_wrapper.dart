import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setting_bloc.dart';
import 'setting_page.dart';

@RoutePage()
class SettingWrapperPage extends StatelessWidget {
  const SettingWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: const SettingPage(),
    );
  }
}
