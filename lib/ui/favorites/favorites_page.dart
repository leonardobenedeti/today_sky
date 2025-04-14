import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/ui/favorites/widgets/favorite_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesLoadedState) {
            if (state.apodList.isEmpty) {
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is FavoritesErrorState) {
            // TODO(leo): Error state page
            return Center(
              child: Text('Error'),
            );
          }

          if (state is FavoritesLoadedState) {
            final orderedList = state.apodList;
            orderedList.sort((a, b) => b.date.compareTo(a.date));
            if (orderedList.isNotEmpty) {
              return ListView(
                children:
                    orderedList.map((e) => FavoriteCard(apod: e)).toList(),
              );
            }
            // TODO(leo): empty state
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
