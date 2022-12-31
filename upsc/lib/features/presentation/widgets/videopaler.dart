import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    videoPlayerController = VideoPlayerController.network(widget.Videourl);
    videoPlayerController!.initialize();
    chewieController = ChewieController(
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      fullScreenByDefault: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      customControls: const CupertinoControls(
          backgroundColor: Colors.black, iconColor: Colors.white),
      videoPlayerController: videoPlayerController!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: chewieController != null
          ? SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Chewie(controller: chewieController!))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Loading"),
              ],
            ),
      //: const Center(child: CircularProgressIndicator())
    );
  }
}
