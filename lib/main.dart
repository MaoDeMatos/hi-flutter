import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/state/theme_state.dart';
import '/state/global_state.dart';
import '/pages/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeState(),
    child: const WordGeneratorApp(),
  ));
}

class WordGeneratorApp extends StatelessWidget {
  const WordGeneratorApp({super.key});
  static const _title = 'Word generator app';

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<ThemeState>();
    var currentThemeMode = themeState.getThemeMode();
    var isUsingUserPalette = themeState.getIsUsingUserPalette();

    // System bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if ((currentThemeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.light) ||
        currentThemeMode == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));
    }

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: _title,
        home: ChangeNotifierProvider(
          create: (context) => GlobalState(),
          child: const HomePage(),
        ),
        // Color theme options
        themeMode: currentThemeMode,
        theme: ThemeData(
          colorScheme: isUsingUserPalette
              ? lightColorScheme ?? defaultLightColorScheme
              : defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: isUsingUserPalette
              ? darkColorScheme ?? defaultDarkColorScheme
              : defaultDarkColorScheme,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
