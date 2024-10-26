import 'package:flutter/material.dart';

import 'spacer.dart';
import 'text.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final Widget? leading;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool border;

  const AppListTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.border = true,
  });

  @override
  Widget build(BuildContext context) {
    Border? borderWidget;
    Widget subTitle = const SizedBox();
    if (subtitle != null) {
      subTitle = Padding(
        padding: AppSpacer.edgeInsetsTop8,
        child: Text(
          subtitle!,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      );
    }
    if (border) {
      borderWidget = Border(
        bottom: BorderSide(color: Theme.of(context).dividerColor),
      );
    }
    return GestureDetector(
      onTap: onPressed,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Padding(
              padding: AppSpacer.edgeInsetsRight16,
              child: leading ?? AppSpacer.emptyBox,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: borderWidget,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ThemedText(
                              title,
                              type: ThemedTextType.subTitle1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subTitle,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppSpacer.edgeInsetsLeft16,
                      child: trailing ?? AppSpacer.emptyBox,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
