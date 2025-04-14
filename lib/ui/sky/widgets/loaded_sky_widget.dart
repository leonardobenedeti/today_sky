import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_sky/data/model/apod_request_data_model.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';
import 'package:today_sky/logic/favorites/favorites_cubit.dart';
import 'package:today_sky/logic/sky/sky_cubit.dart';
import 'package:today_sky/ui/favorites/widgets/favorite_button.dart';
import 'package:today_sky/ui/sky/widgets/empty_sky_widget.dart';
import 'package:today_sky/ui/sky/widgets/video_widget.dart';

class LoadedHomeSky extends StatefulWidget {
  final ApodResponseDataModel apod;

  const LoadedHomeSky({required this.apod, super.key});

  @override
  State<LoadedHomeSky> createState() => _LoadedHomeSkyState();
}

class _LoadedHomeSkyState extends State<LoadedHomeSky>
    with TickerProviderStateMixin {
  final _sheetController = DraggableScrollableController();
  bool _isExpanded = false;
  static const double _expandThreshold = 0.3;

  bool _isHDSelected = false;
  String urlMedia = '';

  late DateTime selectedDate;

  late SkyCubit skyCubit;
  late FavoritesCubit favoritesCubit;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.apod.date;
    parseURLPicture();

    skyCubit = BlocProvider.of<SkyCubit>(context);

    _sheetController.addListener(() {
      final extent = _sheetController.size;
      final newState = extent > _expandThreshold;
      if (newState != _isExpanded) {
        setState(() {
          _isExpanded = newState;
        });
      }
    });
  }

  void selectHDPicture() {
    setState(() {
      _isHDSelected = !_isHDSelected;
    });
    parseURLPicture();
  }

  void parseURLPicture() {
    setState(() {
      urlMedia = _isHDSelected ? widget.apod.hdUrl : widget.apod.url;
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      currentDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      skyCubit.fetchSky(
        requestParams: ApodRequestDataModel(date: picked),
      );
    }
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDateLabel = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Stack(
      children: [
        if (widget.apod.mediaType.isVideo) ...[
          VideoWidget(
            mediaURL: urlMedia,
          ),
        ] else ...[
          InteractiveViewer(
            constrained: false,
            minScale: 1,
            maxScale: 10,
            child: CachedNetworkImage(
              imageUrl: urlMedia,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 500),
              fadeOutDuration: Duration(milliseconds: 300),
              placeholderFadeInDuration: Duration(milliseconds: 300),
              placeholder: (context, url) => EmptySkyWidget(),
              errorWidget: (context, url, error) => EmptySkyWidget(
                withError: false,
              ),
            ),
          ),
        ],
        Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).size.height * 0.16,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.apod.hdUrl.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: selectHDPicture,
                  icon: Icon(
                    _isHDSelected ? Icons.hd : Icons.hd_outlined,
                    color: _isHDSelected ? Colors.black : Colors.white,
                  ),
                  label: Text('Better Quality'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        _isHDSelected ? Colors.black : Colors.white,
                    backgroundColor:
                        Colors.white.withValues(alpha: _isHDSelected ? .7 : .2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ElevatedButton.icon(
                onPressed: () => _selectDate(),
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                label: Text(formattedDateLabel),
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
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.15,
          minChildSize: 0.15,
          maxChildSize: 0.6,
          controller: _sheetController,
          builder: (context, scrollController) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: _isExpanded ? 0.7 : 0.4),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.all(16).copyWith(bottom: 52),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.apod.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                      FavoriteButton(apod: widget.apod),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.apod.explanation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
