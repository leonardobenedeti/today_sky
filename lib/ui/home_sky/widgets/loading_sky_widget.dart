import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptySkyWidget extends StatelessWidget {
  const EmptySkyWidget({this.withError = false, super.key});

  final bool withError;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.expand(
          child: Lottie.asset(
            'assets/loading.json',
            fit: BoxFit.cover,
          ),
        ),
        if (withError) ...[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/empty_sky.png',
                  width: MediaQuery.of(context).size.width * .6),
              Text(
                'APOD Não encontrado',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ] else ...[
          CircularProgressIndicator(),
        ]
      ],
    );
  }
}
