import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:today_sky/ui/sky/widgets/empty_sky_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    required this.mediaURL,
    this.onlyThumb = false,
    super.key,
  });
  final String mediaURL;
  final bool onlyThumb;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  String ytID = '';
  String ytThumb = '';

  @override
  void initState() {
    super.initState();

    ytID = Uri.dataFromString(widget.mediaURL).path.split('/').last;
    ytThumb = 'http://img.youtube.com/vi/$ytID/default.jpg';

    _controller = YoutubePlayerController(
      initialVideoId: ytID,
      flags: const YoutubePlayerFlags(
        mute: true,
        autoPlay: true,
        disableDragSeek: false,
        hideControls: true,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onlyThumb
        ? CachedNetworkImage(
            imageUrl: ytThumb,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            fadeInDuration: Duration(milliseconds: 500),
            fadeOutDuration: Duration(milliseconds: 300),
            placeholderFadeInDuration: Duration(milliseconds: 300),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: [
              EmptySkyWidget(),
              Center(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.purple,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
              )
            ],
          );
  }
}
