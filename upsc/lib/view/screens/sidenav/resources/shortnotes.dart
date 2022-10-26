import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
import 'package:upsc/util/color_resources.dart';

class ShortNotesScreen extends StatefulWidget {
  const ShortNotesScreen({Key? key}) : super(key: key);

  @override
  State<ShortNotesScreen> createState() => _ShortNotesScreenState();
}

class _ShortNotesScreenState extends State<ShortNotesScreen> {
  final TextEditingController _searchtest = TextEditingController();

  @override
  void initState() {
    context
        .read<ApiBloc>()
        .add(const GetResources(key: 'Category', value: 'Daily News'));
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
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text("Unable to get data"),
            );
          }
          if (state is ApiResourcesSuccess) {
            if (state.resources.data.isEmpty) {
              return const Center(
                child: Text('There is no resources'),
              );
            }
            return _bodyWidget(state.resources.data);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container _bodyWidget(List<ResourcesDataModel> resources) {
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
                  resource: resources[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}