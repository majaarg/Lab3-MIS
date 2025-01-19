import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Joke> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Jokes'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites added yet!'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final joke = favorites[index];
          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),
          );
        },
      ),
    );
  }
}
