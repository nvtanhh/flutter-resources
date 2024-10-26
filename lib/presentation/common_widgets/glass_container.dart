import 'dart:ui';

import 'package:flutter/material.dart';

import 'spacer.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius borderRadius;
  final Color? color;
  final EdgeInsets padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.blurSigma = 1.0,
    this.borderRadius = AppSpacer.radius8,
    this.color,
    this.padding = AppSpacer.edgeInsetsAll8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(.05),
            borderRadius: borderRadius,
            border: Theme.of(context).brightness == Brightness.light
                ? Border.all(
                    color: Colors.grey.withOpacity(.3),
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
