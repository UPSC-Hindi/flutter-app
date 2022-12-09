import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/notes_model.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/localfiles.dart';

class SampleNotesScreen extends StatefulWidget {
  const SampleNotesScreen({Key? key, required this.resourceDataSourceImpl})
      : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;

  @override
  State<SampleNotesScreen> createState() => _SampleNotesScreenState();
}

class _SampleNotesScreenState extends State<SampleNotesScreen> {
  @override
  void initState() {
    Localfilesfind.initState();
    super.initState();
    
  }
  @override
  void dispose() {
    super.dispose();
  }

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
          future: widget.resourceDataSourceImpl.getNotes(filter: 'sample'),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                NotesModel? response = snapshots.data;
                if (response!.status) {
                  return NotesWidget(
                    resources: response.data, heading: 'Sample Notes',
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

class NotesWidget extends StatefulWidget {
  final List<NotesDataModel> resources;
  final String heading;
  const NotesWidget({Key? key, required this.resources, required this.heading}) : super(key: key);
  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  String filterText = '';
  late List<NotesDataModel> resources = widget.resources;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SearchBarWidget(
            searchText: widget.heading,
            onChanged: (String value) {
              setState(() {
                filterText = value;
                resources = widget.resources
                    .where(
                      (element) => element.title.toLowerCase().contains(
                            filterText.toLowerCase(),
                          ),
                    )
                    .toList();
              });
            },
          ),
          FractionallySizedBox(
            widthFactor: 0.90,
            child: ListView.builder(
              itemCount: resources.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ResourcesContainerWidget(
                  title: resources[index].title,
                  uploadFile: resources[index].fileUrl.fileLoc,
                  fileSize: resources[index].fileUrl.fileSize,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
