import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

import 'package:word_generator/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(234, 148, 147, 1),
  );
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(234, 148, 147, 1),
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // System bars
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        // Top bar
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarIconBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        // Bottom bar
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: 'Word generator app',
          home: MyHomePage(),
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
