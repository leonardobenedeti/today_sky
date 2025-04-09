import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/data/model/apod_request_data_model.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';
import 'package:today_sky/data/repository/apod_repository.dart';

part 'sky_state.dart';

class SkyCubit extends Cubit<SkyState> {
  ApodRepository apodRepository;

  SkyCubit([ApodRepository? repository])
      : apodRepository = repository ?? ApodRepository(),
        super(SkyErrorState());

  Future<void> fetchSky({ApodRequestDataModel? requestParams}) async {
    emit(SkyLoadingState());

    try {
      final apod = await apodRepository.fetchApod(requestParams: requestParams);
      emit(SkyLoadedState(apod));
    } catch (e) {
      emit(SkyErrorState());
    }
  }
}
