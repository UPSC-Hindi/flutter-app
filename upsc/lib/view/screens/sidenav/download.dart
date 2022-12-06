import 'dart:io' as io;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final ReceivePort _port = ReceivePort();
  List<Map> downloadsListMaps = [];

  @override
  void initState() {
    super.initState();
    task();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      var task = downloadsListMaps.where((element) => element['id'] == id);
      task.forEach((element) {
        element['progress'] = progress;
        element['status'] = status;
        setState(() {});
      });
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future task() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    getTasks!.forEach((_task) {
      Map _map = Map();
      _map['status'] = _task.status;
      _map['progress'] = _task.progress;
      _map['id'] = _task.taskId;
      _map['filename'] = _task.filename;
      _map['savedDirectory'] = _task.savedDir;
      if ([
        const DownloadTaskStatus(3), //completed successfully.
        const DownloadTaskStatus(
            1), //The task is scheduled, but is not running yet.
        const DownloadTaskStatus(6), //paused
        const DownloadTaskStatus(2), //in progress
      ].contains(_map['status'])) {
        downloadsListMaps.insert(0, _map);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.download,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: ColorResources.buttoncolor,
                  unselectedLabelColor: ColorResources.gray,
                  labelColor: ColorResources.buttoncolor,
                  tabs: [
                    Tab(text: Languages.video),
                    //Tab(text: Languages.testSeries),
                    Tab(text: Languages.resources),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  //EmptyWidget(image: SvgImages.emptyCard, text: "There in no Videos"),
                  // EmptyWidget(
                  //     image: SvgImages.emptyCard,
                  //     text: "There in no Test Series"),
                  EmptyWidget(
                      image: SvgImages.emptyCard, text: "There in no videos"),
                  _videoCardWidget(context),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _videoCardWidget(BuildContext context) {
    return SafeArea(
      child: downloadsListMaps.isEmpty
          ? EmptyWidget(
              image: SvgImages.emptyCard, text: "There in no Resources")
          : SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: downloadsListMaps.length,
                  itemBuilder: (BuildContext context, index) {
                    Map _map = downloadsListMaps[index];
                    String _filename = _map['filename'];
                    int _progress = _map['progress'];
                    DownloadTaskStatus _status = _map['status'];
                    String _id = _map['id'];
                    String _savedDirectory = _map['savedDirectory'];
                    print(_savedDirectory);
                    List<io.FileSystemEntity> _directories =
                        io.Directory(_savedDirectory)
                            .listSync(followLinks: true);
                    var _file =
                        _directories.isNotEmpty ? _directories.first : null;
                    return GestureDetector(
                      onTap: () => OpenFile.open("$_savedDirectory/$_filename"),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorResources.gray),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5),
                                    child: Icon(
                                      Icons.picture_as_pdf,
                                      size: 30,
                                      color: ColorResources.buttoncolor,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Text(
                                            _filename.split('.').first,
                                            style:
                                                GoogleFonts.notoSansDevanagari(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        _status == DownloadTaskStatus.complete
                                            ? const Text('')
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text('$_progress%'),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              LinearProgressIndicator(
                                                            value:
                                                                _progress / 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buttons(_status, _id, index),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  Widget buttons(DownloadTaskStatus _status, String taskid, int index) {
    void changeTaskID(String taskid, String newTaskID) {
      Map task = downloadsListMaps.firstWhere(
        (element) => element['taskId'] == taskid,
        orElse: () => {},
      );
      task['taskId'] = newTaskID;
      setState(() {});
    }

    return _status == DownloadTaskStatus.canceled
        ? GestureDetector(
            child: const Icon(Icons.cached, size: 30, color: Colors.green),
            onTap: () {
              FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                changeTaskID(taskid, newTaskID!);
              });
            },
          )
        : _status == DownloadTaskStatus.failed
            ? GestureDetector(
                child: const Icon(Icons.cached, size: 30, color: Colors.green),
                onTap: () {
                  FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                    changeTaskID(taskid, newTaskID!);
                  });
                },
              )
            : _status == DownloadTaskStatus.paused
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.play_arrow,
                            size: 30, color: Colors.blue),
                        onTap: () {
                          FlutterDownloader.resume(taskId: taskid).then(
                            (newTaskID) => changeTaskID(taskid, newTaskID!),
                          );
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.close,
                            size: 30, color: Colors.red),
                        onTap: () {
                          FlutterDownloader.cancel(taskId: taskid);
                        },
                      )
                    ],
                  )
                : _status == DownloadTaskStatus.running
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: const Icon(Icons.pause,
                                size: 30, color: Colors.green),
                            onTap: () {
                              FlutterDownloader.pause(taskId: taskid);
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.close,
                                size: 30, color: Colors.red),
                            onTap: () {
                              FlutterDownloader.cancel(taskId: taskid);
                            },
                          )
                        ],
                      )
                    : _status == DownloadTaskStatus.complete
                        ? GestureDetector(
                            child: const Icon(Icons.delete,
                                size: 30, color: Colors.red),
                            onTap: () {
                              downloadsListMaps.removeAt(index);
                              FlutterDownloader.remove(
                                  taskId: taskid, shouldDeleteContent: true);
                              setState(() {});
                            },
                          )
                        : Container();
  }
}
