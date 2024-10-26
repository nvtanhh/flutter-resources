import 'dart:ui';

import 'package:flutter/material.dart';

import 'spacer.dart';

class CommonPage extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomAppBar;
  final WillPopCallback? onWillPop;
  final EdgeInsets padding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final String? backgroundImage;
  final bool isBlurBackground;

  const CommonPage({
    super.key,
    required this.body,
    this.appBar,
    this.bottomAppBar,
    this.onWillPop,
    this.padding = AppSpacer.edgeInsetsHorizontal16,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.backgroundImage,
    this.isBlurBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop != null ? onWillPop! : () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        appBar: appBar,
        body: SafeArea(
          child: Container(
            padding: padding,
            decoration: backgroundImage == null
                ? null
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(backgroundImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
            child: isBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: body,
                  )
                : body,
          ),
        ),
        bottomNavigationBar: bottomAppBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
