import 'package:flutter/material.dart';
import 'package:mis_labs2/models/joke.dart';
import 'package:mis_labs2/providers/favorite_jokes_provider.dart';
import 'package:provider/provider.dart';

class JokesList extends StatelessWidget {
  final List<Joke> jokes;

  const JokesList({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];
        bool isFavorite = context.read<FavoriteJokesProvider>().favoriteJokes.any((favoriteJoke) =>
        favoriteJoke.setup == joke.setup && favoriteJoke.punchline == joke.punchline);
        if(isFavorite)
          {
            joke.isFavorite=true;
          }
        return Card(
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            title: Text(joke.setup, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(joke.punchline),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {

                context.read<FavoriteJokesProvider>().toggleFavorite(joke);
                (context as Element).markNeedsBuild();
              },
            ),
          ),
        );
      },
    );
  }
}
