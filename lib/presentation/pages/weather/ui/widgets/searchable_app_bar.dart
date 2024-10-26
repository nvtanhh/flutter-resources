import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/entities/weather.dart';
import '../../../../common_widgets/common_widget.index.dart';

class SearchableWeatherAppBar extends StatefulWidget {
  final Weather? weather;
  final void Function(String) onSearch;
  final bool isRefreshing;

  const SearchableWeatherAppBar({
    super.key,
    required this.weather,
    required this.onSearch,
    this.isRefreshing = false,
  });

  @override
  State<SearchableWeatherAppBar> createState() =>
      _SearchableWeatherAppBarState();
}

class _SearchableWeatherAppBarState extends State<SearchableWeatherAppBar> {
  static const Duration _searchAnimationDuration = Duration(milliseconds: 300);
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);

  void _toggleSearch() {
    _isSearching.value = !_isSearching.value;
    if (_isSearching.value) {
      FocusScope.of(context).requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _onSubmitted(String value) {
    _isSearching.value = false;
    widget.onSearch(value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (_, bool isSearching, __) {
            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                AnimatedOpacity(
                  opacity: !isSearching ? 1 : 0,
                  duration: _searchAnimationDuration,
                  curve: Curves.easeInOutCubic,
                  child: _buildTimeAndPlace(),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: _searchAnimationDuration,
                    alignment: Alignment.centerRight,
                    width: isSearching ? constraints.maxWidth : 60,
                    curve: Curves.easeInOutCubic,
                    child: AppTextField(
                      controller: TextEditingController(),
                      maxLines:1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: !isSearching ? Colors.transparent : null,
                        hintText: AppLocalizations.of(context)!
                            .global__search_city_hint,
                        suffixIcon: widget.isRefreshing
                            ? _buildRefreshingIndicator()
                            : GestureDetector(
                                onTap: _toggleSearch,
                                child: isSearching
                                    ? AppIcon(AppIcons.close)
                                    : AppIcon(AppIcons.search),
                              ),
                        border: isSearching ? null : InputBorder.none,
                        disabledBorder: isSearching ? null : InputBorder.none,
                        focusedBorder: isSearching ? null : InputBorder.none,
                        enabledBorder: isSearching ? null : InputBorder.none,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: !isSearching ? _toggleSearch : null,
                      onSubmitted: _onSubmitted,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRefreshingIndicator() {
    return const SizedBox(
      height: 20.0,
      width: 20.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    );
  }

  Widget _buildTimeAndPlace() {
    final localName = AppLocalizations.of(context)!.localeName;
    final date = DateFormat.yMMMMd(localName).format(DateTime.now());
    return SizedBox(
      height: 56.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThemedText(
            date,
            type: ThemedTextType.titleMedium,
          ),
          AppSpacer.sizedBoxH8,
          if (widget.weather != null) _buildWeatherLocation(),
        ],
      ),
    );
  }

  Widget _buildWeatherLocation() {
    return Row(
      children: [
        Transform.translate(
          offset: const Offset(-4.0, 0),
          child: AppIcon(AppIcons.location),
        ),
        ThemedText(
          '${widget.weather!.cityName}, '.toUpperCase(),
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        ThemedText(
          widget.weather!.country.toUpperCase(),
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
