import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

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
