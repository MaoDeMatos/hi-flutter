import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:word_generator/main.dart';
import 'package:word_generator/components/word_card.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    var icon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;

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
