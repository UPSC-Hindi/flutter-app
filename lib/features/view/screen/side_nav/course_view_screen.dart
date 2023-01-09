import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc_web/features/controller/course_controller.dart';
import 'package:upsc_web/features/model/courses_model/MyCoursesModel.dart';
import 'package:upsc_web/features/model/courses_model/RecordedVideoModel.dart';
import 'package:upsc_web/features/model/courses_model/course_notes_model.dart';
import 'package:upsc_web/features/view/cubit/pdf_viewer/pdf_viewer_cubit.dart';
import 'package:upsc_web/features/view/widget/empty_widget.dart';
import 'package:upsc_web/features/view/widget/resource_container_widget.dart';
import 'package:upsc_web/features/view/widget/video_player_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';

import 'resources/youtube_notes.dart';

class CourseViewScreen extends StatefulWidget {
  const CourseViewScreen({
    Key? key,
    required this.lecture,
    required this.batch,
  }) : super(key: key);

  final List<LectureDetail> lecture;
  final BatchDetails batch;

  @override
  State<CourseViewScreen> createState() => _CourseViewScreenState();
}

class _CourseViewScreenState extends State<CourseViewScreen> {
  CoursesController coursesController = CoursesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.batch.batchName,
          style: TextStyle(
            color: ColorResources.textblack,
          ),
        ),
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(
          color: ColorResources.textblack,
        ),
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(height: 50),
            child: TabBar(
              indicatorColor: ColorResources.buttoncolor,
              labelColor: ColorResources.buttoncolor,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Info"),
                Tab(text: "Videos"),
                Tab(text: "Notes"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.batch.batchName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.batch.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9),
                                    borderRadius: BorderRadius.circular(90)),
                                child: Text(
                                  'Duration',
                                  style: GoogleFonts.notoSansDevanagari(
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                  ),
                                  Text(
                                      '  ${widget.batch.endingDate.difference(widget.batch.startingDate).inDays} Days'),
                                  const Expanded(child: SizedBox()),
                                  Row(children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                    ),
                                    Text(
                                        'Starts : ${DateFormat("dd-MM-yyyy").format(widget.batch.startingDate)}')
                                  ]),
                                ],
                              ),
                              // Container(
                              //   margin:
                              //       const EdgeInsets.symmetric(vertical: 10),
                              //   padding: const EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //       color: const Color(0xFfD9D9D9),
                              //       borderRadius: BorderRadius.circular(90)),
                              //   child: Text(
                              //     'Faculty  ',
                              //     style: GoogleFonts.notoSansDevanagari(
                              //         fontSize: 16),
                              //   ),
                              // ),
                              // Container(
                              //   height: 100,
                              //   child: ListView.builder(
                              //     itemCount: widget.batch.teacher.length,
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (context, index) => Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 5.0),
                              //       child: Column(
                              //         children: [
                              //           CachedNetworkImage(
                              //             imageUrl: widget.batch.teacher[index]
                              //                 .profilePhoto,
                              //             placeholder: (context, url) =>
                              //                 const Center(
                              //                     child:
                              //                         CircularProgressIndicator()),
                              //             errorWidget: (context, url, error) =>
                              //                 const Icon(Icons.error),
                              //             height: 70,
                              //           ),
                              //           SizedBox(
                              //             width: 70,
                              //             child: Text(
                              //               widget
                              //                   .batch.teacher[index].fullName,
                              //               textAlign: TextAlign.center,
                              //               style:
                              //                   GoogleFonts.notoSansDevanagari(
                              //                       fontSize: 16,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //               overflow: TextOverflow.ellipsis,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Demo Video",
                          style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ColorResources.textblack),
                        ),
                        Container(
                          height: 120,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: ColorResources.textWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorResources.gray.withOpacity(0.5),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.normal)
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.batch.demoVideo.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.all(5),
                              width: 130,
                              height: 90,
                              child: YouTubeContainerWidget(
                                videoUrl: widget.batch.demoVideo[index].fileLoc,
                                height: 90,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: widget.lecture.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _infoCardWidget(context, widget.lecture[index]),
                        )
                      ],
                    ),
                  ),
                ),
                CoursesVideoWidget(
                  batchId: widget.batch.id,
                  coursesController: coursesController,
                ),
                BatchNotesWidget(
                  batchId: widget.batch.id,
                  coursesController: coursesController,
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Container _infoCardWidget(BuildContext context, LectureDetail lecture) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          title: Text(lecture.lectureTitle),
          // subtitle:Text('Starts : ${DateFormat("dd-MM-yyyy",'UTC').parse(lecture.startingDate)}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${lecture.startingDate.split(" ")[1]} to ${lecture.endingDate.split(" ")[1]}",
                style: TextStyle(fontSize: 15),
              ),
              Text('Date: ${lecture.startingDate.split(" ")[0]}'),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            onPressed: () async {
              // await [Permission.camera, Permission.microphone].request();
              // lecture.lecture_type == "YT"
              //     ? Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           YTClassScreen(lecture: lecture)),
              // )
              //     : callApiJoinStreamingScreen(lecture);
              //Navigator.of(context).pushNamed('joinstreaming');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(lecture.LiveOrRecorded == "Live" ? 'Start Now' : "View",
                    style: GoogleFonts.notoSansDevanagari()), // <-- Text
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BatchNotesWidget extends StatelessWidget {
  const BatchNotesWidget(
      {Key? key, required this.batchId, required this.coursesController})
      : super(key: key);
  final String batchId;
  final CoursesController coursesController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CourseNotesModel>(
        future: coursesController.getCourseNotes(batchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data!.data!.isEmpty
                  ? EmptyWidget(
                      image: SvgImages.emptyCard, text: "There is no Notes")
                  : ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      //todo
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BlocProvider(
                          create: (context) => PdfViewerCubit(),
                          child: ResourcesContainerWidget(
                            resourcetype:
                                snapshot.data!.data![index].resourceType,
                            title: snapshot.data!.data![index].title,
                            uploadFile:
                                snapshot.data!.data![index].uploadFile.fileLoc,
                            fileSize:
                                snapshot.data!.data![index].uploadFile.fileSize,
                          ),
                        ),
                      ),
                    );
            } else {
              return const Center(child: Text("Something Went Wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class CoursesVideoWidget extends StatefulWidget {
  const CoursesVideoWidget({
    Key? key,
    required this.batchId,
    required this.coursesController,
  }) : super(key: key);
  final String batchId;
  final CoursesController coursesController;

  @override
  State<CoursesVideoWidget> createState() => _CoursesVideoWidgetState();
}

class _CoursesVideoWidgetState extends State<CoursesVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecordedVideoModel>(
        future: widget.coursesController.getCourseRecordedVideo(widget.batchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data!.data!.isEmpty
                  ? EmptyWidget(
                      image: SvgImages.emptyCard, text: "There is no video")
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _recordedVideoBody(snapshot.data!.data![index]);
                      },
                    );
              //  ListView.builder(
              //     itemCount: videoList!.length,
              //     itemBuilder: (context, index) =>
              //         _recordedVideoWidget(videoList![index]),
              //   );
            } else {
              return const Center(child: Text("Something Went Wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _recordedVideoBody(RecordedVideoDataModel lectureName) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text(
              lectureName.lectureName!,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: lectureName.listofvideos!.length,
            itemBuilder: (BuildContext context, int index) {
              return _recordedVideoWidget(lectureName.listofvideos![index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _recordedVideoWidget(Listofvideos videosdata) {
    return InkWell(
      onTap: () {
        print("recorded video");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerWidget(
              videoLink: videosdata.fileUrl!.fileLoc!,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.gray),
                child: Icon(Icons.play_circle, color: ColorResources.textWhite),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videosdata.title!,
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  // Text(
                  //   '1hr 2mins',
                  //   style: GoogleFonts.notoSansDevanagari(
                  //       fontSize: 16, color: ColorResources.gray),
                  // ),
                ],
              ),
            ],
          ),
          const Divider(),
        ]),
      ),
    );
  }
}
