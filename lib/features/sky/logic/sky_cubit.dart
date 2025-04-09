import 'package:flutter_bloc/flutter_bloc.dart';

part 'sky_state.dart';

class SkyCubit extends Cubit<SkyState> {
  SkyCubit() : super(SkyErrorState());
}
