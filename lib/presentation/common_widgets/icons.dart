import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'spacer.dart';

class AppIcon extends StatelessWidget {
  final AppIconData iconData;
  final RpIconSize? size;
  final double? customSize;
  final Color? color;

  static const double largeSize = AppSpacer.space32;
  static const double mediumSize = AppSpacer.space24;
  static const double smallSize = AppSpacer.space20;

  const AppIcon(
    this.iconData, {
    super.key,
    this.size = RpIconSize.medium,
    this.customSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    late double iconSize;

    if (customSize != null) {
      iconSize = customSize!;
    } else {
      switch (size) {
        case RpIconSize.large:
          iconSize = largeSize;
          break;
        case RpIconSize.medium:
          iconSize = mediumSize;
          break;
        case RpIconSize.small:
          iconSize = smallSize;
          break;
        default:
          throw 'Unsupported RpIconSize';
      }
    }

    final finalColor = color ?? Theme.of(context).iconTheme.color;

    if (iconData.nativeIcon != null) {
      return Icon(
        iconData.nativeIcon,
        size: iconSize,
        color: finalColor,
      );
    }
    final iconFilePath =
        iconData.filePath ?? 'assets/icons/${iconData.filename!}';
    if (iconFilePath.endsWith('.svg')) {
      return SvgPicture.asset(
        iconFilePath,
        color: finalColor,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.scaleDown,
      );
    } else {
      return Image.asset(
        iconFilePath,
        height: iconSize,
        color: finalColor,
        colorBlendMode: BlendMode.modulate,
      );
    }
  }
}

class AppIcons {
  static AppIconData backIOS =
      const AppIconData(nativeIcon: Icons.arrow_back_ios_new_rounded);
  static AppIconData arrowRight =
      const AppIconData(nativeIcon: Icons.keyboard_arrow_right);
  static AppIconData language =
      const AppIconData(nativeIcon: Icons.language_outlined);
  static AppIconData darkMode =
      const AppIconData(nativeIcon: Icons.nights_stay_outlined);
  static AppIconData color =
      const AppIconData(nativeIcon: Icons.color_lens_outlined);
  static AppIconData font =
      const AppIconData(nativeIcon: Icons.font_download_outlined);
  static AppIconData weatherOutline =
      const AppIconData(nativeIcon: Icons.cloud_outlined);
  static AppIconData weather = const AppIconData(nativeIcon: Icons.cloud);
  static AppIconData settingOutline =
      const AppIconData(nativeIcon: Icons.settings_outlined);
  static AppIconData setting = const AppIconData(nativeIcon: Icons.settings);
  static AppIconData search =
      const AppIconData(nativeIcon: Icons.search_rounded);
  static AppIconData location =
      const AppIconData(nativeIcon: Icons.location_on_rounded);
  static AppIconData locationOff =
      const AppIconData(nativeIcon: Icons.location_off_rounded);
  static AppIconData close = const AppIconData(nativeIcon: Icons.close);
}

class AppIconData {
  final String? filename;
  final String? filePath;
  final IconData? nativeIcon;

  const AppIconData({
    this.nativeIcon,
    this.filePath,
    this.filename,
  });
}

enum RpIconSize { small, medium, large, extraLarge }
