import 'package:flutter/material.dart';
import 'favorites_screen.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';
import 'jokes_screen.dart';
import 'random_joke_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiServices.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load joke types'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  type: jokeTypes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesScreen(type: jokeTypes[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
