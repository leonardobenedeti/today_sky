import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/core/dependency_injector.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';
import 'package:today_sky/data/repository/apod_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  ApodRepository apodRepository;

  FavoritesCubit([ApodRepository? repository])
      : apodRepository = repository ?? DependencyInjector.get<ApodRepository>(),
        super(FavoritesLoadingState());

  Future<void> fetchFavorites() async {
    emit(FavoritesLoadingState());

    try {
      final apodList = apodRepository.fetchFavorites();
      emit(FavoritesLoadedState(apodList));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  Future<void> checkFavorites(ApodResponseDataModel apod) async {
    emit(FavoritesLoadingState());

    try {
      final isFavorite = apodRepository.checkFavorite(apod);
      emit(FavoriteCheckedState(isFavorite));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  Future<void> selectFavorite(ApodResponseDataModel apod) async {
    emit(FavoritesLoadingState());

    try {
      apodRepository.selectFavorite(apod);
      final isFavorite = apodRepository.checkFavorite(apod);
      emit(FavoriteCheckedState(isFavorite));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }
}
