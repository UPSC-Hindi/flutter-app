import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
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
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<ResourcesModel>(
          future: widget.resourceDataSourceImpl.getCourseIndex(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                ResourcesModel? response = snapshots.data;
                if (response!.status) {
                  return CourseIndexBody(resources: response.data);
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



class CourseIndexBody extends StatefulWidget {
  const CourseIndexBody({Key? key, required this.resources}) : super(key: key);
  final List<ResourcesDataModle> resources;
  @override
  State<CourseIndexBody> createState() => _CourseIndexBodyState();
}

class _CourseIndexBodyState extends State<CourseIndexBody> {
  String filterText = '';
  late List<ResourcesDataModle> resources = widget.resources;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SearchBarWidget(
            onChanged: (String value) {
              setState(() {
                filterText = value;
                resources = widget.resources.where(
                      (element) => element.title.toLowerCase().contains(
                    filterText.toLowerCase(),
                  ),
                ).toList();
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
                  uploadFile: resources[index].fileUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
