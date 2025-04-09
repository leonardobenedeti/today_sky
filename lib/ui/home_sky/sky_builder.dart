import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_sky/logic/sky_cubit.dart';
import 'package:today_sky/ui/home_sky/sky_page.dart';

class SkyBuilder extends StatelessWidget {
  const SkyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkyCubit()..fetchSky(),
      child: Scaffold(body: SkyPage()),
    );
  }
}
