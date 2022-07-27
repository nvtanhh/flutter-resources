import 'package:flutter/material.dart';

import 'text.dart';

enum ButtonType { normal, outline, text }

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final bool disabled;
  final ButtonType type;
  final Widget? icon;
  final MainAxisSize mainAxisSize;

  const AppButton(
    this.text, {
    Key? key,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabled = false,
    this.type = ButtonType.normal,
    this.mainAxisSize = MainAxisSize.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildLoading(Color color) {
      if (!loading) return Container();
      return Row(
        children: [
          const SizedBox(width: 8),
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: color,
            ),
          )
        ],
      );
    }

    switch (type) {
      case ButtonType.outline:
        if (icon != null) {
          return OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(64, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ThemedText(
                  text,
                  type: ThemedTextType.button,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildLoading(Theme.of(context).primaryColor)
              ],
            ),
          );
        }
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(64, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: disabled ? null : onPressed,
          child: Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ThemedText(
                text,
                type: ThemedTextType.button,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildLoading(Theme.of(context).primaryColor)
            ],
          ),
        );

      case ButtonType.text:
        if (icon != null) {
          return TextButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ThemedText(
                  text,
                  type: ThemedTextType.button,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildLoading(Theme.of(context).primaryColor)
              ],
            ),
          );
        }
        return TextButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ThemedText(
                text,
                type: ThemedTextType.button,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildLoading(Theme.of(context).primaryColor)
            ],
          ),
        );
      default:
        if (icon != null) {
          return ElevatedButton.icon(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(64, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: icon!,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ThemedText(
                  text,
                  type: ThemedTextType.button,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildLoading(Colors.white)
              ],
            ),
          );
        }
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(64, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ThemedText(
                text,
                type: ThemedTextType.button,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildLoading(Colors.white)
            ],
          ),
        );
    }
  }
}
