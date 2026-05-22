import 'package:flutter/material.dart';

import '../theme/nerdland_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: NerdLandTheme.themeMode,
      builder: (context, themeMode, _) {
        final isDark = themeMode == ThemeMode.dark;

        return IconButton(
          tooltip: isDark ? 'Mudar para tema claro' : 'Mudar para tema escuro',
          icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          onPressed: NerdLandTheme.toggleTheme,
        );
      },
    );
  }
}
