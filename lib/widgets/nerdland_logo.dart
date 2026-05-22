import 'package:flutter/material.dart';

class NerdLandLogo extends StatelessWidget {
  final bool showText;
  final double size;

  NerdLandLogo({
    super.key,
    this.showText = true,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            'N',
            style: TextStyle(
              fontSize: size * 0.45,
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (showText) ...[
          SizedBox(width: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'NERD',
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                TextSpan(
                  text: 'LAND',
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}