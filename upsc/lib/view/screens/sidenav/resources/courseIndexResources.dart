import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/notes_model.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';

class CoursesIndexResources extends StatefulWidget {
  const CoursesIndexResources({Key? key, required this.resourceDataSourceImpl})
      : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;
  @override
  State<CoursesIndexResources> createState() => _CoursesIndexResourcesState();
}

class _CoursesIndexResourcesState extends State<CoursesIndexResources> {
  String? datetoshow;
  @override
  void initState() {
    super.initState();
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
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
          'Course Index',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<NotesModel>(
          future: widget.resourceDataSourceImpl.getNotes(filter: 'Pathyakram'),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                NotesModel? response = snapshots.data;
                if (response!.status) {
                  return _bodyWidget(context, response.data);
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

  Container _bodyWidget(BuildContext context, List<NotesDataModel> resources) {
    return Container(
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.90,
        child: ListView.builder(
          itemCount: resources.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ResourcesContainerWidget(
              title: resources[index].title,
              uploadFile: resources[index].fileUrl,
            );
          },
        ),
      ),
    );
  }
}
