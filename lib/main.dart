import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umdb/cubits/favourite_movie_cubit.dart';
import 'package:umdb/cubits/popular_movie_cubit.dart';
import 'package:umdb/cubits/top_rated_movie_cubit.dart';
import 'package:umdb/models/popular_movie_hive.dart';
import 'package:umdb/pages/movie_grid_screen.dart';
import 'package:umdb/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PopularMovieAdapter()); // Registering Adapter
  await Hive.openBox<PopularMovieHive>('popular-movies');
  runApp(const UmdbApp());
}

class UmdbApp extends StatelessWidget {
  const UmdbApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieCubit>(
          create: (BuildContext context) => PopularMovieCubit(),
        ),
        BlocProvider<FavouriteMovieCubit>(
          create: (BuildContext context) => FavouriteMovieCubit(),
        ),
        BlocProvider<TopRatedMovieCubit>(
          create: (BuildContext context) => TopRatedMovieCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'UMDB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
