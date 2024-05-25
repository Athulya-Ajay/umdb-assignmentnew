import 'package:flutter/material.dart';
import 'package:umdb/pages/popular_movies_page.dart';

class NewPopularMovies extends StatefulWidget {
  const NewPopularMovies({super.key});

  @override
  State<NewPopularMovies> createState() => _NewPopularMoviesState();
}

class _NewPopularMoviesState extends State<NewPopularMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: const PopularMoviesPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement functionality for floating action button here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
