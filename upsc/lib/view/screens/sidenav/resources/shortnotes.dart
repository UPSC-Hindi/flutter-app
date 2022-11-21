import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/notes_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
import 'package:upsc/util/color_resources.dart';

class ShortNotesScreen extends StatefulWidget {
  const ShortNotesScreen({Key? key, required this.resourceDataSourceImpl})
      : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;

  @override
  State<ShortNotesScreen> createState() => _ShortNotesScreenState();
}

class _ShortNotesScreenState extends State<ShortNotesScreen> {
  final TextEditingController _searchtest = TextEditingController();

  @override
  void initState() {
    context
        .read<ApiBloc>()
        .add(const GetResources(key: 'Category', value: 'short Notes'));
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
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<NotesModel>(
          future: widget.resourceDataSourceImpl.getNotes(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                NotesModel? response = snapshots.data;
                if (response!.status) {
                  return _bodyWidget(response.data);
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

  Container _bodyWidget(List<NotesDataModel> resources) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SearchBarWidget(searchtest: _searchtest),
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
