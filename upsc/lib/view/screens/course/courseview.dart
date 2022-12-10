import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/batch_notes_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/recorded_video_model.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/features/presentation/widgets/videopaler.dart';
import 'package:upsc/features/presentation/widgets/youtube_player_widget.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/joinStreaming.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: widget.batch.demoVideo.length,
                            itemBuilder: (BuildContext context, int index) {
                              return videolist(widget.batch.demoVideo[index]);
                            },
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
                ),
                BatchNotesWidget(batchId: widget.batch.id)
              ]),
            ),
          ),
        ]),
      ),
    );
  }
  youtubevideo(url) {
    String videoId = YoutubePlayer.convertUrlToId(url)!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YoutubePlayerWidget(
          videoId: videoId,
        ),
      ),
    );
  }

  Widget videolist(MyCoursesBanner demoVideo) {
    return InkWell(
      onTap: () {
        print("he");
        print(demoVideo.fileLoc);
        demoVideo.bannerfileType == "Video"
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayVideoFromNetwork(
              Videourl: demoVideo.fileLoc,
            ),
          ),
        )
            : youtubevideo(demoVideo.fileLoc);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: ColorResources.gray.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.play_circle,
                size: 40,
              ),
              // Text('Raman Deep',
              //     style: GoogleFonts.notoSansDevanagari(
              //         fontSize: 16, fontWeight: FontWeight.bold)
              // )
            ],
          ),
        ),
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
            children: const [
              Text(
                '9:00 AM to 12:00 PM',
                style: TextStyle(fontSize: 15),
              ),
              Text('Date- 08/10/2022 '),
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
              await [Permission.camera, Permission.microphone].request();
              callApiJoinStreamingScreen(lecture);
              //Navigator.of(context).pushNamed('joinstreaming');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Start Now',
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

  Future<BaseModel<JoinStreaming>> callApiJoinStreamingScreen(
      LectureDetail lecture) async {
    JoinStreaming response;
    var random = Random();
    int uid = random.nextInt(999); //= 123;
    Map<String, dynamic> body = {
      "channelName": lecture.lectureTitle,
      "expireTime": "3600",
      "tokentype": "uid",
      "Stream_title": "Mahadeva@12546987",
      "account": "askd",
      "Description": lecture.description,
      "uid": uid.toString()
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      print(uid);
      String acess_token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
      response = await RestClient(RetroApi().dioData(acess_token))
          .joinmeetingRequest(body);

      if (response.status!) {
        print(response.rtmToke);
        print(response.rtcToken);
        setState(() {
          Preferences.hideDialog(context);
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JoinStreamingScreen(
                userID: response.userID!,
                userblock: response.userBlocked!,
                rtctoken: response.rtcToken!,
                rtmtoken: response.rtmToke!,
                uid: uid,
                lecture: lecture),
          ),
        );
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        setState(() {
          Preferences.hideDialog(context);
        });
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}

class BatchNotesWidget extends StatelessWidget {
  const BatchNotesWidget({Key? key, required this.batchId}) : super(key: key);
  final String batchId;

  @override
  Widget build(BuildContext context) {
    RemoteDataSourceImpl batchNotesDataModel = RemoteDataSourceImpl();
    List<BatchNotesDataModel>? notesList;
    return FutureBuilder<List<BatchNotesDataModel>>(
        initialData: notesList,
        future: batchNotesDataModel.getBatchNotes(batchId: batchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              notesList = snapshot.data!;
              return notesList!.isEmpty
                  ? EmptyWidget(
                      image: SvgImages.emptyCard, text: "There is no Notes")
                  : ListView.builder(
                      itemCount: notesList!.length,
                      itemBuilder: (context, index) => ResourcesContainerWidget(
                        title: notesList![index].title,
                        uploadFile: notesList![index].uploadFile.fileLoc,
                        fileSize: notesList![index].uploadFile.fileSize,
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
  }) : super(key: key);
  final String batchId;

  @override
  State<CoursesVideoWidget> createState() => _CoursesVideoWidgetState();
}

class _CoursesVideoWidgetState extends State<CoursesVideoWidget> {
  final ReceivePort _port = ReceivePort();

  Future download(String url, String? name) async {
    final baseStorage = await getExternalStorageDirectory();

    print('directory:${baseStorage!.path}');
    //todo pls chek this variable use
    List files = baseStorage.listSync();
    await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      // optional: header send with url (auth token etc)
      savedDir: baseStorage.path,
      showNotification: true,
      // show download progress in status bar (for Android)
      fileName: '${name!}.${url.split('.').last}',
      openFileFromNotification:
          false, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    List<RecordedVideoDataModel>? videoList;
    return FutureBuilder<List<RecordedVideoDataModel>>(
        initialData: videoList,
        future: remoteDataSourceImpl.getRecordedVideo(batchId: widget.batchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              videoList = snapshot.data!;
              return videoList!.isEmpty
                  ? EmptyWidget(
                      image: SvgImages.emptyCard, text: "There is no video")
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: videoList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _recordedvideobody(videoList![index]);
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

  Widget _recordedvideobody(RecordedVideoDataModel lectureName) {
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
        //download(videosdata.fileUrl!.fileLoc!, videosdata.title);
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
