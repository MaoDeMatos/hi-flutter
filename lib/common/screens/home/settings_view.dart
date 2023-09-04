import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/theme_state.dart';

// TODO: Export this in a separate file
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<ThemeState>();
    var currentThemeMode = themeState.getThemeMode();

    return SafeArea(
      child: ListView(
        children: [
          const ListTile(
            title: Text('Color theme selection'),
          ),
          ...ThemeMode.values
              .map(
                (themeMode) => ListTile(
                  title: Text(themeMode.name.toCapitalized()),
                  leading: Radio(
                    groupValue: currentThemeMode,
                    value: themeMode,
                    onChanged: (_) {
                      themeState.setThemeMode(themeMode);
                    },
                  ),
                ),
              )
              .toList(),
          ListTile(
            title: const Text('Use user color palette'),
            trailing: Switch(
              value: themeState.getIsUsingUserPalette(),
              onChanged: themeState.toggleIsUsingUserPalette,
            ),
          ),
        ],
      ),
    );
  }
}
