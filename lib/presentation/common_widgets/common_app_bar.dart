import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'icons.dart';
import 'text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textIconColor;
  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final double? height;
  final List<Widget>? actions;
  final bool autoImplyLeading;

  const CommonAppBar({
    super.key,
    this.backgroundColor,
    this.textIconColor = Colors.black,
    this.title = '',
    this.titleWidget,
    this.actions,
    this.height = kToolbarHeight,
    this.leading,
    this.autoImplyLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: textIconColor,
      ),
      leading: leading ?? _buildBackButton(context),
      title: titleWidget ??
          ThemedText(
            title!,
            type: ThemedTextType.heading6,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    if (!autoImplyLeading) return null;
    return IconButton(
      onPressed: () => context.router.back(),
      icon: AppIcon(
        AppIcons.backIOS,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
