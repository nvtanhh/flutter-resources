import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../configs/configs.index.dart';
import '../../../../../core/utils/language.dart';
import '../../../../common_widgets/common_widget.index.dart';
import '../../../../shared_blocs/language/language_cubit.dart';

@RoutePage()
class LanguageSettingPage extends StatefulWidget {
  const LanguageSettingPage({super.key});

  @override
  State<LanguageSettingPage> createState() => _LanguageSettingPageState();
}

class _LanguageSettingPageState extends State<LanguageSettingPage> {
  final _textLanguageController = TextEditingController();
  late List<Locale> supportedLocales;

  @override
  void didChangeDependencies() {
    supportedLocales = context.read<LanguageCubit>().state.supportedLocales;
    super.didChangeDependencies();
  }

  void _onChangeLanguage(Locale locale) {
    getIt<LanguageCubit>().changeLanguage(locale);
  }

  @override
  void dispose() {
    _textLanguageController.dispose();
    super.dispose();
  }

  void _filterLanguage(String text) {
    if (text.isEmpty) {
      setState(() {
        supportedLocales = getIt<LanguageCubit>().state.supportedLocales;
      });
      return;
    }
    setState(() {
      supportedLocales = supportedLocales
          .where(
            (item) =>
                LanguageUtils.getGlobalLanguageName(item.languageCode, context)
                    .toUpperCase()
                    .contains(text.toUpperCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
            child: AppTextField(
              controller: _textLanguageController,
              labelText: AppLocalizations.of(context)!.settings__language_title,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.global__search,
                isDense: false,
              ),
              onChanged: _filterLanguage,
            ),
          ),
          Expanded(
            child: BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Widget? trailing;
                    final locale = supportedLocales[index];
                    if (locale == state.locale) {
                      trailing = Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return AppListTitle(
                      title: LanguageUtils.getGlobalLanguageName(
                        locale.languageCode,
                        context,
                      ),
                      trailing: trailing,
                      onPressed: () => _onChangeLanguage(locale),
                      border: locale != supportedLocales.last,
                    );
                  },
                  itemCount: supportedLocales.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: AppLocalizations.of(context)!.settings__language_change_language,
    );
  }
}
