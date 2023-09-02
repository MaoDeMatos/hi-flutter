import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

import '/pages/my_home_page.dart';

void main() {
  runApp(const WordGeneratorApp());
}

class GlobalState extends ChangeNotifier {
  // Current word
  var current = WordPair.random();

  void generatePair() {
    current = WordPair.random();
    notifyListeners();
  }

  // Favorite words
  var favorites = <WordPair>{};

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class WordGeneratorApp extends StatelessWidget {
  const WordGeneratorApp({super.key});
  static const _title = 'Word generator app';

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(234, 148, 147, 1),
  );
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(234, 148, 147, 1),
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    // System bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
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

    return ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: _title,
          home: const MyHomePage(),
          // Color theme options
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
