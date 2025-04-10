import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:today_sky/logic/sky_cubit.dart';

class EmptySkyWidget extends StatelessWidget {
  const EmptySkyWidget({this.withError = false, super.key});

  final bool withError;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Lottie.asset(
              'assets/loading.json',
              fit: BoxFit.cover,
            ),
          ),
          if (withError) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/empty_sky.png',
                    width: MediaQuery.of(context).size.width * .6),
                Text(
                  'Sky not found...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<SkyCubit>().fetchSky();
                  },
                  label: Text('Back to present'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white.withValues(alpha: .7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            CircularProgressIndicator(),
          ]
        ],
      ),
    );
  }
}
