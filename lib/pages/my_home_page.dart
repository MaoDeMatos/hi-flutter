import 'package:flutter/material.dart';

import 'package:word_generator/pages/favorites_page.dart';
import 'package:word_generator/pages/generator_page.dart';

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
          height: 75,
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
