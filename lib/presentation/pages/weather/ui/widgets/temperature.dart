import 'package:flutter/material.dart';

import '../../../../common_widgets/common_widget.index.dart';

class TemperatureWidget extends StatelessWidget {
  final String temperature;

  const TemperatureWidget(
    this.temperature, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThemedText(
          temperature,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Transform.translate(
            offset: const Offset(45, -10),
            child: ThemedText(
              '°',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
