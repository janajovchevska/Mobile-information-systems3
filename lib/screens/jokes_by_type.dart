import 'package:flutter/material.dart';
import 'package:mis_labs2/models/joke.dart';
import 'package:mis_labs2/services/api_services.dart';
import 'dart:convert';
import 'package:mis_labs2/widgets/jokes_list.dart';


class JokesByTypeScreen extends StatefulWidget {
  final String type;
  const JokesByTypeScreen({super.key, required this.type});

  @override
  State<JokesByTypeScreen> createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    getJokesByTypeFromAPI();
  }

  void getJokesByTypeFromAPI() async {
    ApiService.getJokesByType(widget.type).then((response) {
      var data = jsonDecode(response.body);
      setState(() {
        jokes = List<Joke>.from(data.map((item) => Joke.fromJson(item)));
      });
    }).catchError((e) {
      print("Failed to load jokes of type: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes of type: ${widget.type}'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : JokesList(jokes: jokes),
    );
  }
}