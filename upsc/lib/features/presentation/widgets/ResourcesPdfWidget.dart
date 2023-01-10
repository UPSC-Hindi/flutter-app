import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/features/presentation/widgets/videopaler.dart';
import 'package:upsc/features/presentation/widgets/youtube_player_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/localfiles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResourcesContainerWidget extends StatefulWidget {
  const ResourcesContainerWidget(
      {Key? key,
      required this.title,
      required this.uploadFile,
      required this.resourcetype,
      required this.fileSize})
      : super(key: key);
  final String title;
  final String uploadFile;
  final String resourcetype;
  final String? fileSize;

  @override
  State<ResourcesContainerWidget> createState() =>
      _ResourcesContainerWidgetState();
}

class _ResourcesContainerWidgetState extends State<ResourcesContainerWidget> {
  final ReceivePort _port = ReceivePort();

  Future download(String url, String? name) async {
    final baseStorage = await getExternalStorageDirectory();

    print('directory:${baseStorage!.path}');
    //todo pls chek this variable use
    String? status = await FlutterDownloader.enqueue(
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
    print(status);
  }

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      //todo pls chek this variable use
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorResources.borderColor),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: widget.resourcetype == 'file' ||
                        widget.resourcetype == 'pdf'
                    ? CachedNetworkImage(
                        imageUrl: SvgImages.pdfimage,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : widget.resourcetype == 'video'
                        ? const Icon(
                            Icons.video_collection_rounded,
                            size: 40,
                            color: Color.fromARGB(255, 143, 51, 51),
                          )
                        : widget.resourcetype == 'yt_videos'
                            ? CachedNetworkImage(
                                height: 40,
                                imageUrl: SvgImages.youtube,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : const Icon(
                                Icons.wordpress_outlined,
                                size: 40,
                                color: Color.fromARGB(255, 143, 51, 51),
                              ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSansDevanagari(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.gray),
                    ),
                  ),
                  Text(
                    widget.resourcetype == "file" ||
                            widget.resourcetype == 'pdf' ||
                            widget.resourcetype == 'video'
                        ? widget.fileSize!
                        : "",
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 10, color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
          Localfilesfind.localfiles.contains(widget.title)
              ? Icon(
                  Icons.verified,
                  color: ColorResources.buttoncolor,
                )
              : InkWell(
                  onTap: () async {
                    Map<Permission, PermissionStatus> status = await [
                      Permission.storage,
                      Permission.manageExternalStorage,
                    ].request();
                    if (await Permission.storage.isGranted) {
                      if (widget.resourcetype == "file" ||
                          widget.resourcetype == "pdf") {
                        flutterToast("Donwloading... ");
                        download(widget.uploadFile, widget.title);
                      } else if (widget.resourcetype == "video") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayVideoFromNetwork(
                              Videourl: widget.uploadFile,
                            ),
                          ),
                        );
                      } else if (widget.resourcetype == "yt_videos") {
                        String videoId =
                            YoutubePlayer.convertUrlToId(widget.uploadFile)!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubePlayerWidget(
                                      videoId: videoId,
                                    )));
                      } else {
                        launchUrl(Uri.parse(widget.uploadFile),
                            mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        widget.resourcetype == "file" ||
                                widget.resourcetype == "pdf"
                            ? 'PDF'
                            : widget.resourcetype == "video" ||
                                    widget.resourcetype == "yt_videos"
                                ? "play"
                                : 'Link',
                        style: GoogleFonts.notoSansDevanagari(
                          fontSize: 15,
                          color: ColorResources.buttoncolor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        //todo this dead code pls check onces
                        widget.resourcetype == "file" ||
                                widget.resourcetype == "pdf"
                            ? Icons.file_download_outlined
                            : Icons.link,
                        size: 25,
                        color: ColorResources.buttoncolor,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
