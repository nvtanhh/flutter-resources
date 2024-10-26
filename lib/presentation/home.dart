import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'common_widgets/common_widget.index.dart';
import 'pages/setting/ui/setting_wrapper.dart';
import 'pages/weather/ui/weather_wrapper.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    ///AppState add observer
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///Handle AppState
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          WeatherWrapperPage(),
          SettingWrapperPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: AppIcon(AppIcons.weatherOutline),
            activeIcon: AppIcon(
              AppIcons.weather,
              color: Theme.of(context).primaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: AppIcon(AppIcons.settingOutline),
            activeIcon: AppIcon(
              AppIcons.setting,
              color: Theme.of(context).primaryColor,
            ),
            label: '',
          ),
        ],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
