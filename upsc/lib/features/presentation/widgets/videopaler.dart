import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:video_player/video_player.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  final String Videourl;
  const PlayVideoFromNetwork({Key? key, required this.Videourl})
      : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.Videourl);
    videoPlayerController!.initialize();
    chewieController = ChewieController(
        fullScreenByDefault: true,
        autoInitialize: true,
        videoPlayerController: videoPlayerController!,
        autoPlay: true);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Chewie(controller: chewieController!)
        //: const Center(child: CircularProgressIndicator())
        );
  }
}
