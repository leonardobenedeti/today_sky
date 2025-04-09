import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/features/sky/logic/sky_cubit.dart';
import 'package:today_sky/features/sky/ui/widgets/error_sky_widget.dart';
import 'package:today_sky/features/sky/ui/widgets/loaded_sky_widget.dart';
import 'package:today_sky/features/sky/ui/widgets/loading_sky_widget.dart';

class SkyPage extends StatelessWidget {
  const SkyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkyCubit, SkyState>(
      builder: (context, state) {
        if (state is SkyErrorState) return ErrorSkyWidget();
        if (state is SkyLoadedState) return LoadedSkyWidget();

        return LoadingSkyWidget();
      },
    );
  }
}
