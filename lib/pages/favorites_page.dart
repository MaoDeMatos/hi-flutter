import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GlobalState>();

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
