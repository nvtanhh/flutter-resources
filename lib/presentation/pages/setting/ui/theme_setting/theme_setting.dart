import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/injector/injection.dart';
import '../../../../../domain/entities/theme_entity.dart';
import '../../../../common_widgets/common_widget.index.dart';
import '../../../../shared_blocs/shared_bloc_index.dart';

class ThemeSettingPage extends StatelessWidget {
  const ThemeSettingPage({Key? key}) : super(key: key);

  void onChange(ThemeEntity theme) {
    locator<ThemeCubit>().onChangeTheme(theme: theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Theme'),
        elevation: 0,
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                Widget trailing = const SizedBox();
                final item = state.supportedThemes![index];
                if (item.name == state.theme!.name) {
                  trailing = Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  );
                }

                return AppListTitle(
                  title: item.name,
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: item.primary,
                  ),
                  trailing: trailing,
                  onPressed: () => onChange(item),
                  border: item != state.supportedThemes!.last,
                );
              },
              itemCount: state.supportedThemes?.length ?? 0,
            ),
          );
        },
      ),
    );
  }
}
