import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc_web/features/model/resources_model/notes_model.dart';
import 'package:upsc_web/features/view/cubit/pdf_viewer/pdf_viewer_cubit.dart';
import 'package:upsc_web/features/view/widget/resource_container_widget.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/features/view/widget/search_bar_widget.dart';

class NotesWidget extends StatefulWidget {
  final List<NotesDataModel> resources;
  final String heading;

  const NotesWidget({Key? key, required this.resources, required this.heading})
      : super(key: key);

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
          ResponsiveWidget(
            mobile: griedViewWidget(1,10/2),
            web: griedViewWidget(3,27/7),
            tab: griedViewWidget(2,27/8),
          ),
        ],
      ),
    );
  }

  GridView griedViewWidget(int count,double childRatio) {
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
            resourcetype: resources[index].resourcetype,
            title: resources[index].title,
            uploadFile: resources[index].fileUrl.fileLoc,
            fileSize: resources[index].fileUrl.fileSize ?? 0.toString(),
          ),
        );
      },
    );
  }
}
