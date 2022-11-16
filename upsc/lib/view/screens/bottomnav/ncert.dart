import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/youtube_player_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NcertScreen extends StatefulWidget {
  const NcertScreen({Key? key}) : super(key: key);

  @override
  State<NcertScreen> createState() => _NcertScreenState();
}

class _NcertScreenState extends State<NcertScreen> {
  @override
  void initState() {
    context.read<ApiBloc>().add(GetYouTubeVideo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'NCERT Batches',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
          if (state is ApiYoutubeVideoSuccess) {
            return state.videoList.isEmpty
                ? const Center(child: Text('There is No Video'))
                : _bodyWidget(state.videoList);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  SingleChildScrollView _bodyWidget(List<VideoDataModel> videData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Courses',
              style: TextStyle(fontSize: 24),
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
                  crossAxisSpacing: 4.0,
                ),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return YouTubeContainerWidget(
                    videoUrl: videData[index].videoUrl, height: 140,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class YouTubeContainerWidget extends StatefulWidget {
  const YouTubeContainerWidget({Key? key, required this.videoUrl, required this.height})
      : super(key: key);
  final String videoUrl;
  final double  height;
  @override
  State<YouTubeContainerWidget> createState() => _YouTubeContainerWidgetState();
}

class _YouTubeContainerWidgetState extends State<YouTubeContainerWidget> {
  String videoId = '';

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
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
                  fit: BoxFit.cover,
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