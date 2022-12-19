import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/resources_model/notes_model.dart';
import 'package:upsc_web/features/view/widget/notes_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';

class SampleNotesScreen extends StatefulWidget {
  const SampleNotesScreen({Key? key, required this.resourceController})
      : super(key: key);
  final ResourceController resourceController;
  @override
  State<SampleNotesScreen> createState() => _SampleNotesScreenState();
}

class _SampleNotesScreenState extends State<SampleNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Sample Notes',
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<NotesModel>(
          future: widget.resourceController.getNotes(filter: 'sample'),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                NotesModel? response = snapshots.data;
                if (response!.status) {
                  return NotesWidget(
                    resources: response.data,
                    heading: 'Sample Notes',
                  );
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
}
