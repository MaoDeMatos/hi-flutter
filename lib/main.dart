import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // System bars
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        // Top bar
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        // Bottom bar
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Word generator app',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromRGBO(234, 148, 147, 1)),
          useMaterial3: true,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var pages = <Widget>[
      GeneratorPage(),
      FavoritesPage(),
      ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) => SizedBox(
          height: 100,
          child: Card(
            color: index % 2 == 0
                ? theme.colorScheme.tertiaryContainer
                : theme.colorScheme.primary,
            child: Center(
              child: Text(
                '${index + 1}',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: index % 2 == 0
                      ? theme.colorScheme.onTertiaryContainer
                      : theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      )
    ];

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        extendBody: true,
        body: Row(
          children: [
            SafeArea(
              top: false,
              bottom: false,
              child: NavigationRail(
                groupAlignment: 0,
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text("Home")),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text("Favorites")),
                  NavigationRailDestination(
                      icon: Icon(Icons.list), label: Text("Test list")),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: pages[selectedIndex],
              ),
            )
          ],
        ),
      );
    });
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "You have ${appState.favorites.length} favorites:",
          ),
        ),
        for (var word in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(word.asLowerCase),
          ),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WordCard(pair: pair),
          SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  appState.generatePair();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
