import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../configs/configs.index.dart';
import 'route/route.dart';
import 'shared_blocs/language/language_cubit.dart';
import 'shared_blocs/theme/theme_cubit.dart';
import 'shared_blocs/user/user_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (_, data) {
        if (!data.hasData) {
          return const CircularProgressIndicator();
        }

        final appRouter = getIt<AppRouter>();

        return BlocProvider<UserCubit>(
          create: (_) => getIt<UserCubit>(),
          child: BlocProvider(
            create: (_) => getIt<LanguageCubit>(),
            child: BlocProvider<ThemeCubit>(
              create: (_) => getIt<ThemeCubit>()..init(),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  return BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, languageState) {
                      return BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, theme) {
                          return MaterialApp.router(
                            debugShowCheckedModeBanner: false,
                            // Localization
                            localizationsDelegates: const [
                              AppLocalizations.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                              GlobalCupertinoLocalizations.delegate,
                            ],
                            supportedLocales: languageState.supportedLocales,
                            locale: languageState.locale,
                            localeResolutionCallback:
                                getIt<LanguageCubit>().localeResolutionCallback,
                            // Theme
                            theme: theme.lightTheme,
                            darkTheme: theme.darkTheme,
                            // Route
                            routerConfig: appRouter.config(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
