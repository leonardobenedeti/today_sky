import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/logic/sky_cubit.dart';
import 'package:today_sky/ui/home_sky/widgets/loaded_sky_widget.dart';
import 'package:today_sky/ui/home_sky/widgets/loading_sky_widget.dart';

class SkyPage extends StatelessWidget {
  const SkyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<SkyCubit, SkyState>(
          builder: (context, state) {
            if (state is SkyErrorState) return EmptySkyWidget(withError: true);
            if (state is SkyLoadedState) return LoadedHomeSky(apod: state.apod);

            return EmptySkyWidget();
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Today Sky',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text('Favoritos'),
                      icon: Icon(
                        Icons.favorite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
