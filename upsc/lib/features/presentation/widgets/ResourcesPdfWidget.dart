import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesContainerWidget extends StatefulWidget {
  const ResourcesContainerWidget({Key? key, required this.resource})
      : super(key: key);
  final ResourcesDataModel resource;

  @override
  State<ResourcesContainerWidget> createState() =>
      _ResourcesContainerWidgetState();
}

class _ResourcesContainerWidgetState extends State<ResourcesContainerWidget> {
  ReceivePort _port = ReceivePort();

  Future download(String url, String? name) async {
    final baseStorage = await getExternalStorageDirectory();

    print('directory:${baseStorage!.path}');

    List files = baseStorage.listSync();

    await FlutterDownloader.enqueue(
      url: url,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: baseStorage.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      fileName: '${name!}.${url.split('.').last}',
      openFileFromNotification:false, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
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
              CachedNetworkImage(
                imageUrl: SvgImages.pdfimage,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.resource.title,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.gray),
                  ),
                  Text(
                    '2.5 MB',
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              Map<Permission, PermissionStatus> status = await [
                Permission.storage,
                Permission.manageExternalStorage,
              ].request();
              if (await Permission.storage.isGranted) {
                if (widget.resource.resourceType == 'file') {
                  download(widget.resource.fileUrl, widget.resource.title);
                } else {
                  launchUrl(Uri.parse(widget.resource.fileUrl),
                      mode: LaunchMode.externalApplication);
                }
              }
            },
            child: Column(
              children: [
                Text(
                  widget.resource.resourceType == 'file' ? 'PDF' : 'Link',
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorResources.buttoncolor,
                      fontWeight: FontWeight.w700),
                ),
                Icon(
                  widget.resource.resourceType == 'file'
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
