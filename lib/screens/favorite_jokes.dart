import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_labs2/providers/favorite_jokes_provider.dart';
import 'package:mis_labs2/models/joke.dart';

class FavoriteJokesScreen extends StatelessWidget {

  const FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = Provider.of<FavoriteJokesProvider>(context).favoriteJokes;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text('No favorite jokes yet.'))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return Card(
            elevation: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(joke.setup, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(joke.punchline),
            ),
          );
        },
      ),
    );
  }
}
