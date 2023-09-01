import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: theme.textTheme.displayMedium!
              .copyWith(color: theme.colorScheme.onPrimary),
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
