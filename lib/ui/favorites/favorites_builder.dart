import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/ui/favorites/favorites_page.dart';

class FavoritesBuilder extends StatelessWidget {
  const FavoritesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: FavoritesPage(),
    );
  }
}
