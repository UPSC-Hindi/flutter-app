import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
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
  final player = AudioPlayer();

  Duration? duration;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
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
                  return _bodyWidget(response.data, context);
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

  Widget _bodyWidget(
      List<AirResourcesDataModel> resources, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(
              onChanged: (String value) {
                print(value);
              },
            ),
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
                                  resources[index].data,
                                  style: GoogleFonts.notoSansDevanagari(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.gray),
                                ),
                                Text(
                                  resources[index].audioFile.fileSize,
                                  style: GoogleFonts.notoSansDevanagari(
                                      fontSize: 10, color: ColorResources.gray),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            // duration = await player
                            //     .setUrl(resources[index].audioFile.fileLoc);
                            // player.playing ? player.stop() : player.play();
                          },
                          child: Column(
                            children: [
                              Icon(
                                //todo this dead code pls check onces
                                player.playing ? Icons.pause : Icons.play_arrow,
                                size: 25,
                                color: ColorResources.buttoncolor,
                              ),
                              player.playing
                                  ? Text('pause',
                                      style: GoogleFonts.notoSansDevanagari(
                                        fontSize: 8,
                                        color: ColorResources.buttoncolor,
                                        fontWeight: FontWeight.w700,
                                      ))
                                  : Text(
                                      'Audio Play',
                                      style: GoogleFonts.notoSansDevanagari(
                                        fontSize: 8,
                                        color: ColorResources.buttoncolor,
                                        fontWeight: FontWeight.w700,
                                      ),
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
