import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../configs/configs.index.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../common_widgets/common_widget.index.dart';
import '../../../../shared_blocs/theme/theme_cubit.dart';

@RoutePage()
class ThemeColorSettingPage extends StatelessWidget {
  const ThemeColorSettingPage({super.key});

  void _onChange(ColorTheme theme, {required BuildContext context}) {
    getIt<ThemeCubit>().onChangeTheme(colorTheme: theme);
    context.router.back();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      appBar: CommonAppBar(
        title: AppLocalizations.of(context)!.settings__theme_color,
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                Widget trailing = const SizedBox();
                final item = state.supportedColorThemes![index];
                if (item.name == state.theme!.colorTheme.name) {
                  trailing = Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  );
                }

                return AppListTitle(
                  title: item.name.capitalize(),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: item.primary,
                  ),
                  trailing: trailing,
                  onPressed: () => _onChange(item, context: context),
                  border: item != state.supportedColorThemes!.last,
                );
              },
              itemCount: state.supportedColorThemes?.length ?? 0,
            ),
          );
        },
      ),
    );
  }
}
