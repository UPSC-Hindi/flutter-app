import 'package:flutter/material.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/resources_model/notes_model.dart';
import 'package:upsc_web/features/view/widget/notes_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';

class ShortNotesScreen extends StatefulWidget {
  const ShortNotesScreen({Key? key, required this.resourceController})
      : super(key: key);
  final ResourceController resourceController;

  @override
  State<ShortNotesScreen> createState() => _ShortNotesScreenState();
}

class _ShortNotesScreenState extends State<ShortNotesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Short Notes',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: FutureBuilder<NotesModel>(
          future: widget.resourceController.getNotes(filter: 'shorts'),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                NotesModel? response = snapshots.data;
                if (response!.status) {
                  return NotesWidget(
                    resources: response.data,
                    heading: "Short Notes",
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
