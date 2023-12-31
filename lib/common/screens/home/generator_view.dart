import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/global_state.dart';
import '../../widgets/word_card.dart';

// TODO: Add `AnimatedList` with words history
// TODO: Change styles of the word and main action button
class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GlobalState>();
    var pair = appState.current;

    var icon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WordCard(pair: pair),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  appState.generatePair();
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
