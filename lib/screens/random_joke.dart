import 'package:flutter/material.dart';
import 'package:mis_labs2/models/joke.dart';
import 'package:mis_labs2/services/api_services.dart';
import 'dart:convert';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? randomJoke;

  @override
  void initState() {
    super.initState();
    getRandomJokeFromAPI();
  }
  void getRandomJokeFromAPI() async {
    ApiService.getRandomJoke().then((response) {
      var data = jsonDecode(response.body);
      setState(() {
        randomJoke = Joke.fromJson(data);
      });
    }).catchError((e) {
      print("Failed to load random joke: $e");
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke of the day'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: randomJoke == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: ListTile(
            title: Text(randomJoke!.setup, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(randomJoke!.punchline),
          ),
        ),
      ),
    );
  }
}
