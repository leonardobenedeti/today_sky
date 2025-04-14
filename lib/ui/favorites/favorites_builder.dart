import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/ui/favorites/favorites_page.dart';

class FavoritesBuilder extends StatefulWidget {
  const FavoritesBuilder({super.key});

  @override
  State<FavoritesBuilder> createState() => _FavoritesBuilderState();
}

class _FavoritesBuilderState extends State<FavoritesBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        centerTitle: false,
      ),
      body: FavoritesPage(),
    );
  }
}
