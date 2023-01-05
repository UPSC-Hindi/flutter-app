import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/resources_model/course_index_model.dart';
import 'package:upsc_web/features/view/cubit/pdf_viewer/pdf_viewer_cubit.dart';
import 'package:upsc_web/features/view/widget/resource_container_widget.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/features/view/widget/search_bar_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/langauge.dart';

class CoursesIndexResources extends StatefulWidget {
  const CoursesIndexResources({Key? key, required this.resourceController})
      : super(key: key);
  final ResourceController resourceController;

  @override
  State<CoursesIndexResources> createState() => _CoursesIndexResourcesState();
}

class _CoursesIndexResourcesState extends State<CoursesIndexResources> {
  String? datetoshow;

  @override
  void initState() {
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
    super.initState();
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
          //'Course Index'
          Languages.Course_Index,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<CourseIndexModel>(
          future: widget.resourceController.getCourseIndex(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                CourseIndexModel? response = snapshots.data;
                if (response!.status!) {
                  return CourseIndexBody(resources: response.data!);
                } else {
                  return Text(response.msg!);
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
  final List<CourseIndexDataModel> resources;

  @override
  State<CourseIndexBody> createState() => _CourseIndexBodyState();
}

class _CourseIndexBodyState extends State<CourseIndexBody> {
  String filterText = '';
  late List<CourseIndexDataModel> resources = widget.resources;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SearchBarWidget(
            searchText: 'Course Index',
            onChanged: (String value) {
              setState(() {
                filterText = value;
                resources = widget.resources
                    .where(
                      (element) => element.title!.toLowerCase().contains(
                            filterText.toLowerCase(),
                          ),
                    )
                    .toList();
              });
            },
          ),
          ResponsiveWidget(
            mobile: gridViewWidget(1, 10 / 2),
            web: gridViewWidget(3, 27 / 7),
            tab: gridViewWidget(2, 27 / 8),
          ),
        ],
      ),
    );
  }

  GridView gridViewWidget(int count, double childRatio) {
    return GridView.builder(
      itemCount: resources.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        childAspectRatio: childRatio,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return BlocProvider(
          create: (context) => PdfViewerCubit(),
          child: ResourcesContainerWidget(
            resourcetype: resources[index].resourceType!,
            title: resources[index].title!,
            uploadFile: resources[index].fileUrl!.fileLoc!,
            fileSize: resources[index].fileUrl!.fileSize ?? 0.toString(),
          ),
        );
      },
    );
  }
}
