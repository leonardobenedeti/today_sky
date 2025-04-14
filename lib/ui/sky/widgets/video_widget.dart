import 'package:flutter/material.dart';
import 'package:today_sky/ui/sky/widgets/empty_sky_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({required this.mediaURL, super.key});
  final String mediaURL;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final ytID = Uri.dataFromString(widget.mediaURL).path.split('/').last;

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
    return Stack(
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
