part of 'favorites_cubit.dart';

class FavoritesState {}

final class FavoritesLoadingState extends FavoritesState {}

final class FavoritesLoadedState extends FavoritesState {
  List<ApodResponseDataModel> apodList;

  FavoritesLoadedState(this.apodList);
}

final class FavoritesErrorState extends FavoritesState {}
