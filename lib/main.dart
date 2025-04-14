import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_sky/core/dependency_injector.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/ui/favorites/favorites_builder.dart';
import 'package:today_sky/ui/sky/sky_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await DependencyInjector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: MaterialApp(
        title: 'Today Sky',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => SkyBuilder(),
          '/favorites': (context) => FavoritesBuilder(),
        },
      ),
    );
  }
}
