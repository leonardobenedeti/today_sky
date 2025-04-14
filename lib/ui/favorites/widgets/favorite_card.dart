import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/ui/sky/widgets/video_widget.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({required this.apod, super.key});

  final ApodResponseDataModel apod;

  @override
  Widget build(BuildContext context) {
    final formattedDateLabel = DateFormat('dd/MM/yyyy').format(apod.date);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, apod);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (apod.mediaType.isVideo) ...[
                  VideoWidget(mediaURL: apod.url, onlyThumb: true),
                ] else ...[
                  CachedNetworkImage(
                    imageUrl: apod.url,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    fadeInDuration: Duration(milliseconds: 500),
                    fadeOutDuration: Duration(milliseconds: 300),
                    placeholderFadeInDuration: Duration(milliseconds: 300),
                  ),
                ],
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apod.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                              Text(
                                formattedDateLabel,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<FavoritesCubit>().removeFavorite(apod);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
