import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({required this.apod, super.key});

  final ApodResponseDataModel apod;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().checkFavorites(widget.apod);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoadingState) return CircularProgressIndicator();

        if (state is FavoritesLoadedState) {
          final isFavorite =
              state.apodList.any((apod) => apod.date == widget.apod.date);
          return IconButton(
            onPressed: () =>
                context.read<FavoritesCubit>().selectFavorite(widget.apod),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
