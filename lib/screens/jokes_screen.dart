import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';

class JokeListScreen extends StatefulWidget {
  final String type;

  JokeListScreen({required this.type});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<Joke>> jokes;
  final List<Joke> favorites = [];

  @override
  void initState() {
    super.initState();
    jokes = ApiService.fetchJokesByType(widget.type);
  }

  void addToFavorites(Joke joke) {
    setState(() {
      favorites.add(joke);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to favorites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favorites: favorites),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  joke: jokes[index],
                  onTap: () {},
                  onFavorite: () => addToFavorites(jokes[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
