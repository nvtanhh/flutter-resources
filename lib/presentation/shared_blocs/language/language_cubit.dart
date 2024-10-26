import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../configs/configs.index.dart';
import '../../pages/weather/bloc/weather_bloc.dart';

part 'language_state.dart';

@singleton
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState.initial());

  void changeLanguage(Locale locale) {
    emit(state.copyWith(locale: locale));
    getIt<WeatherBloc>().add(RefreshWeather(language: locale.languageCode));
  }

  Locale? localeResolutionCallback(
    Locale? deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    // if no deviceLocale -> use english
    if (deviceLocale == null) {
      return state.locale;
    }
    // initialize locale from device
    if (state.supportedLocales.contains(deviceLocale)) {
      final matchedLocale = supportedLocales.firstWhere(
        (Locale locale) => locale.languageCode == deviceLocale.languageCode,
      );
      emit(state.copyWith(locale: matchedLocale));
    }
    return state.locale;
  }
}
