import 'package:flutter/material.dart';
import 'package:umdb/pages/top_rated_movies_page.dart';

class NewTopRatedMovies extends StatefulWidget {
  const NewTopRatedMovies({super.key});

  @override
  State<NewTopRatedMovies> createState() => _NewTopRatedMoviesState();
}

class _NewTopRatedMoviesState extends State<NewTopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter functionality here
            },
          ),
        ],
      ),
      body: const TopRatedMoviesPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement functionality for floating action button here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
