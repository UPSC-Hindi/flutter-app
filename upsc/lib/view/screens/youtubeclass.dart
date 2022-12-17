import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTClassScreen extends StatefulWidget {
  final LectureDetail lecture;
  const YTClassScreen({Key? key, required this.lecture}) : super(key: key);

  @override
  State<YTClassScreen> createState() => _YTClassScreenState();
}

class _YTClassScreenState extends State<YTClassScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.lecture.link)!,
      flags: const YoutubePlayerFlags(
        isLive: true,
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.lecture.lectureTitle),
      // ),
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            print(widget.lecture.link);
            return Column(
              children: [
                player,
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.lecture.lectureTitle,
                            style:
                                GoogleFonts.notoSansDevanagari(fontSize: 30)),
                        Text(widget.lecture.description),
                      ]),
                )
                //some other widgets
              ],
            );
          }),
    );
  }
}
