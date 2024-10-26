import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../configs/configs.index.dart';
import '../bloc/weather_bloc.dart';
import 'weather_page.dart';

@RoutePage()
class WeatherWrapperPage extends StatelessWidget {
  const WeatherWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WeatherBloc>()
        ..add(
          WeatherInitialEvent(
            language: AppLocalizations.of(context)!.localeName,
          ),
        ),
      child: const WeatherPage(),
    );
  }
}
