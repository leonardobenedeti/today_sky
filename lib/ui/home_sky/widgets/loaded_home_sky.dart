import 'package:flutter/material.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';

class LoadedHomeSky extends StatelessWidget {
  final ApodResponseDataModel apod;

  const LoadedHomeSky({required this.apod, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(apod.title),
        Text(apod.explanation),
        Text(apod.date.toString()),
        Text(apod.mediaType.name),
      ],
    );
  }
}
