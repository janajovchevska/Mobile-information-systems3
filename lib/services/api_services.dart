import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService{

  static Future<http.Response> getJokeTypes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    return response;

  }

  static Future<http.Response> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    return response;
  }

 static Future<http.Response> getRandomJoke() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    return response;
  }

}
