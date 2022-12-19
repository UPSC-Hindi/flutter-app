import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/resources_model/youtube_notes.dart';
import 'package:upsc_web/features/view/widget/youtube_player_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeNotes extends StatefulWidget {
  const YoutubeNotes({Key? key, required this.resourceController})
      : super(key: key);
  final ResourceController resourceController;

  @override
  State<YoutubeNotes> createState() => _YoutubeNotesState();
}

class _YoutubeNotesState extends State<YoutubeNotes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'Youtube Notes',
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<VideoModel>(
          future: widget.resourceController.getYoutbeNotes(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                VideoModel? response = snapshots.data;
                if (response!.status) {
                  return response.data.isEmpty
                      ? const Center(child: Text('There is No Video'))
                      : _bodyWidget(response.data);
                } else {
                  return Text(response.msg);
                }
              } else {
                return const Text('Server Error');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  SingleChildScrollView _bodyWidget(List<VideoDataModel> videData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Courses',
              style: GoogleFonts.notoSansDevanagari(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 0.8,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return YouTubeContainerWidget(
                    videoUrl: videData[index].videoUrl,
                    height: 125,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class YouTubeContainerWidget extends StatefulWidget {
  const YouTubeContainerWidget(
      {Key? key, required this.videoUrl, required this.height})
      : super(key: key);
  final String videoUrl;
  final double height;
  @override
  State<YouTubeContainerWidget> createState() => _YouTubeContainerWidgetState();
}

class _YouTubeContainerWidgetState extends State<YouTubeContainerWidget> {
  String videoId = '';
  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YoutubePlayerWidget(
              videoId: videoId,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: widget.height,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.gray,
                image: DecorationImage(
                  image: NetworkImage(
                    YoutubePlayer.getThumbnail(videoId: videoId, webp: false),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: ColorResources.textWhite,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
