import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/global_state.dart';

// TODO: Update list style
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GlobalState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        ListTile(
          title: Text("You have ${appState.favorites.length} favorites:"),
        ),
        for (var word in appState.favorites)
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(word.asLowerCase),
          ),
      ],
    );
  }
}
