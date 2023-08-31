import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter first app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
        body: Column(children: [
      Text('A random idea:'),
      Text(appState.current.asLowerCase)
    ]));
  }
}
