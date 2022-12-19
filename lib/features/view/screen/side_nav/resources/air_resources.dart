import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/resources_model/air_resources_model.dart';
import 'package:upsc_web/features/view/widget/search_bar_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';

class AirResourcesScreen extends StatefulWidget {
  const AirResourcesScreen({Key? key, required this.resourceController})
      : super(key: key);
  final ResourceController resourceController;
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
          future: widget.resourceController.getAirResource(),
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
              searchText: 'Search Air',
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
                  return aircard(resources[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget aircard(AirResourcesDataModel resources) {
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
              Image.network(SvgImages.pdfimage),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resources.data,
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.gray),
                  ),
                  Text(
                    resources.audioFile.fileSize,
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 10, color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              duration = await player.setUrl(resources.audioFile.fileLoc);
              player.playing
                  ? setState(() {
                      player.stop();
                    })
                  : setState(() {
                      player.play();
                    });
            },
            child: player.playing
                ? Column(
                    children: [
                      Icon(
                        Icons.pause,
                        size: 25,
                        color: ColorResources.buttoncolor,
                      ),
                      Text('pause',
                          style: GoogleFonts.notoSansDevanagari(
                            fontSize: 8,
                            color: ColorResources.buttoncolor,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  )
                : Column(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 25,
                        color: ColorResources.buttoncolor,
                      ),
                      Text(
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
  }
}
