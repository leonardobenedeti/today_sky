import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';

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

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          constrained: false,
          minScale: 1,
          maxScale: 10,
          child: CachedNetworkImage(
            imageUrl: widget.apod.url,
            alignment: Alignment.center,
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
                padding: const EdgeInsets.all(16),
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
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ))
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
