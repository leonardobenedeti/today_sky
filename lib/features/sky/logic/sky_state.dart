part of 'sky_cubit.dart';

class SkyState {}

final class SkyLoadingState extends SkyState {}

final class SkyLoadedState extends SkyState {
  ApodResponseDataModel apod;

  SkyLoadedState(this.apod);
}

final class SkyErrorState extends SkyState {}
