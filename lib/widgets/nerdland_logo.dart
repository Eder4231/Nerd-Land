import 'package:flutter/material.dart';
import '../theme/nerdland_theme.dart';

class NerdLandLogo extends StatelessWidget {
  final bool showText;
  final double size;

  const NerdLandLogo({
    super.key,
    this.showText = true,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: NerdLandTheme.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            'N',
            style: TextStyle(
              fontSize: size * 0.45,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 12),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'NERD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                TextSpan(
                  text: 'LAND',
                  style: TextStyle(
                    color: NerdLandTheme.primary,
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