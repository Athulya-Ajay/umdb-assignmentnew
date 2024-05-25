import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:umdb/pages/new_popular_page.dart';
import 'package:umdb/pages/new_top_rated_page.dart';

import '../models/movie.dart';

class MovieGridScreen extends StatefulWidget {
  const MovieGridScreen({super.key});

  @override
  State<MovieGridScreen> createState() => _MovieGridScreenState();
}

class _MovieGridScreenState extends State<MovieGridScreen> {
  late Future<MovieList> popularMovies;
  late Future<MovieList> topRatedMovies;

  Future<MovieList> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final jsonResponse = json.decode(jsonString);
    return MovieList.fromJson(jsonResponse);
  }

  Future<MovieList> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('https://movie-api-rish.onrender.com/top-rated'));

    if (response.statusCode == 200) {
      final jsonResponse2 = json.decode(response.body);
      return MovieList.fromJson(jsonResponse2);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    popularMovies = loadJsonData();
    topRatedMovies = fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 46.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Popular Movies', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPopularMovies()),
                );
              }),
              _buildMovieGrid(popularMovies),
              const SizedBox(height: 32),
              _buildSectionTitle('Top Rated Movies', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewTopRatedMovies()),
                );
              }),
              _buildMovieGrid(topRatedMovies),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              'See All',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieGrid(Future<MovieList> movieListFuture) {
    return FutureBuilder<MovieList>(
      future: movieListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final movies = snapshot.data?.items ?? [];
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movies[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(movies[index].year),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
