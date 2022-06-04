import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/theme/common_page.dart';
import '../../../../config/theme/glass_container.dart';
import '../../../../config/theme/spacer.dart';
import '../../../../config/theme/text.dart';
import '../../../../core/extensions/extensions.index.dart';
import '../../../../domain/entities/weather.dart';
import '../bloc/weather_bloc.dart';
import 'widgets/searchable_app_bar.dart';
import 'widgets/temperature.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    context.read<WeatherBloc>().add(
          RefreshWeather(language: AppLocalizations.of(context)?.localeName),
        );
  }

  void _onSearch(BuildContext context, String cityName) {
    context.read<WeatherBloc>().add(
          GetWeatherByCityNameEvent(
            cityName,
            language: AppLocalizations.of(context)?.localeName,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      backgroundImage: 'assets/images/world-map-bg.png',
      isBlurBackground: true,
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            _showErrorSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SearchableWeatherAppBar(
                    weather: state.weather,
                    onSearch: (String city) => _onSearch(context, city),
                    isRefreshing: state is WeatherRefreshing,
                  ),
                ),
                if (state.weather != null)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        children: [
                          _buildCurrentWeather(context, state.weather!),
                          _buildWeatherDetail(context, state.weather!),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentWeather(BuildContext context, Weather weather) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
          color: Theme.of(context).primaryColor,
          filterQuality: FilterQuality.medium,
          colorBlendMode: BlendMode.modulate,
          height: 150,
        ),
        ThemedText(
          weather.description.capitalize(),
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TemperatureWidget(
          weather.temperature.toStringAsFixed(0),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(
    BuildContext context,
    Weather weather,
  ) {
    return Padding(
      padding: AppSpacer.edgeInsetsVertical12,
      child: GlassContainer(
        padding: AppSpacer.edgeInsetsAll16,
        borderRadius: AppSpacer.radius16,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          mainAxisSpacing: 4.0,
          shrinkWrap: true,
          children: <Widget>[
            _buildWeatherDetailInfo(
              context,
              AppLocalizations.of(context)!.weather__feel_like,
              '${weather.tempFeelLike} °C',
            ),
            _buildWeatherDetailInfo(
              context,
              AppLocalizations.of(context)!.weather__wind,
              '${weather.windSpeed} Km/h',
            ),
            _buildWeatherDetailInfo(
              context,
              AppLocalizations.of(context)!.weather__humidity,
              '${weather.humidity} %',
            ),
            _buildWeatherDetailInfo(
              context,
              AppLocalizations.of(context)!.weather__pressure,
              '${weather.pressure} hPa',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetailInfo(
    BuildContext context,
    String title,
    String content,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemedText(
            title,
            type: ThemedTextType.titleMedium,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.6),
                ),
          ),
          AppSpacer.sizedBoxH8,
          ThemedText(
            content,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: AppSpacer.edgeInsetsAll12,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.8),
              borderRadius: AppSpacer.radius24,
            ),
            child: ThemedText(
              errorMessage,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
