import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/air_resource_model.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class AirResourcesScreen extends StatefulWidget {
  const AirResourcesScreen({Key? key, required this.resourceDataSourceImpl})
      : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;
  @override
  State<AirResourcesScreen> createState() => _AirResourcesScreenState();
}

class _AirResourcesScreenState extends State<AirResourcesScreen> {
  final TextEditingController _searchtest = TextEditingController();

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
      //todo pls chek this variable use
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'AIR',
          style: GoogleFonts.notoSansDevanagari(
            color: ColorResources.textblack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<AirResourcesModel>(
          future: widget.resourceDataSourceImpl.getAir(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                AirResourcesModel? response = snapshots.data;
                if (response!.status) {
                  return _bodyWidget(response.data);
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

  Container _bodyWidget(List<AirResourcesDataModel> resources) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(onChanged: (String value) {
              print(value);
            },),
            FractionallySizedBox(
              widthFactor: 0.90,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: resources.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title is not provided ',
                                  style: GoogleFonts.notoSansDevanagari(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.gray),
                                ),
                                Text(
                                  '2.5 MB',
                                  style: GoogleFonts.notoSansDevanagari(
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
                              if (true) {
                                download(resources[index].audioFile.fileName,
                                    resources[index].data);
                              }
                              //todo this dead code pls check onces
                              // else {
                              //   launchUrl(Uri.parse(''),
                              //       mode: LaunchMode.externalApplication);
                              // }
                            }
                          },
                          child: Column(
                            children: [
                              //todo this dead code pls check onces of link why true always
                              Text(
                                true ? 'Audio' : 'Link',
                                style: GoogleFonts.notoSansDevanagari(
                                  fontSize: 15,
                                  color: ColorResources.buttoncolor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                //todo this dead code pls check onces
                                true
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
