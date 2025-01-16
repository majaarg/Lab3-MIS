import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiServices {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  // Fetch joke types
  static Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  // Fetch jokes by type
  static Future<List<Joke>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      final List jokes = json.decode(response.body);
      return jokes.map((joke) => Joke.fromJson(joke)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  // Fetch random joke
  static Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    if (response.statusCode == 200) {
      return Joke.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
