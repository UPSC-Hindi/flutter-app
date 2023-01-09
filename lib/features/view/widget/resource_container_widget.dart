import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/view/cubit/pdf_viewer/pdf_viewer_cubit.dart';
import 'package:upsc_web/features/view/screen/side_nav/resources/youtube_notes.dart';
import 'package:upsc_web/features/view/widget/pdf_viewer_widget.dart';
import 'package:upsc_web/features/view/widget/youtube_player_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResourcesContainerWidget extends StatefulWidget {
  const ResourcesContainerWidget({
    Key? key,
    required this.title,
    required this.uploadFile,
    required this.resourcetype,
    required this.fileSize,
  }) : super(key: key);
  final String title;
  final String uploadFile;
  final String resourcetype;
  final String? fileSize;

  @override
  State<ResourcesContainerWidget> createState() =>
      _ResourcesContainerWidgetState();
}

class _ResourcesContainerWidgetState extends State<ResourcesContainerWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.network(SvgImages.pdfimage),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    constraints: const BoxConstraints(
                      maxWidth: 100,
                    ),
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
                    widget.resourcetype == "file" ? widget.fileSize! : "",
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 10, color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
          BlocConsumer<PdfViewerCubit, PdfViewerState>(
            listener: (context, state) {
              if (state is PdfViewerSuccess) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PdfViewerWidget(bytes: state.bytes),
                  ),
                );
              }
              if (state is PdfViewerError) {
                Utils.toastMessage('Unable To open');
                //TODO Remove if fix
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(
                //     builder: (context) =>
                //         PdfViewerWidget(url: widget.uploadFile),
                //   ),
                // );
              }
            },
            builder: (context, state) {
              if (state is PdfViewerLoading) {
                return CircularProgressIndicator();
              }
              return InkWell(
                onTap: () async {
                  print(widget.resourcetype);
                  if (widget!.resourcetype == 'pdf') {
                    BlocProvider.of<PdfViewerCubit>(context)
                        .viewPdf(widget.uploadFile);
                  }
                  if (widget!.resourcetype == 'link') {
                    if (!await launchUrl(Uri.parse(widget.uploadFile))) {
                      throw 'Could not launch ${widget.uploadFile}';
                    }
                  }
                  if (widget!.resourcetype == 'video') {}
                  if (widget!.resourcetype == 'yt_videos') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoutubePlayerWidget(
                          videoId: YoutubePlayer.convertUrlToId(
                                  widget!.uploadFile) ??
                              '',
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.resourcetype == 'link'
                            ? 'LINK'
                            : widget.resourcetype == 'pdf'
                                ? 'PDF'
                                : "VIDEO",
                        style: GoogleFonts.notoSansDevanagari(
                          fontSize: 15,
                          color: ColorResources.buttoncolor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        //todo this dead code pls check onces
                        widget.resourcetype == "file"
                            ? Icons.file_download_outlined
                            : Icons.link,
                        size: 25,
                        color: ColorResources.buttoncolor,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
