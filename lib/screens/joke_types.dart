import 'package:flutter/material.dart';
import 'package:mis_labs2/services/api_services.dart';
import 'dart:convert';
import 'package:mis_labs2/widgets/joke_types_list.dart';
import 'package:mis_labs2/screens/random_joke.dart';
import 'package:mis_labs2/screens/favorite_jokes.dart';


class JokeTypesScreen extends StatefulWidget {
  const JokeTypesScreen({super.key});

  @override
  State<JokeTypesScreen> createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {

  List<String> jokeTypes = [];
  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    ApiService.getJokeTypes().then((response) {
      var data = jsonDecode(response.body);
      setState(() {
        jokeTypes = List<String>.from(data);
      });
    }).catchError((e) {
      print("Failed to load joke types: $e");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Types'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied_rounded,size: 40,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RandomJokeScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite, size: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteJokesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : JokeTypesList(jokeTypes: jokeTypes),
    );
  }
}