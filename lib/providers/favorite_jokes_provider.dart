import 'package:flutter/material.dart';
import 'package:mis_labs2/models/joke.dart';

class FavoriteJokesProvider with ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => _favoriteJokes;

  void toggleFavorite(Joke joke) {
    if (joke.isFavorite) {
      _favoriteJokes.removeWhere((favJoke) =>
      favJoke.setup == joke.setup && favJoke.punchline == joke.punchline);
      joke.isFavorite = false;
    } else {
      _favoriteJokes.add(joke);
      joke.isFavorite = true;
    }
    notifyListeners();
  }
}
