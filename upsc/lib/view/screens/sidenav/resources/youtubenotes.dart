import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/batch_notes_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/search_bar_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class YoutubeNotesScreen extends StatefulWidget {
  const YoutubeNotesScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeNotesScreen> createState() => _YoutubeNotesScreenState();
}

class _YoutubeNotesScreenState extends State<YoutubeNotesScreen> {
  final TextEditingController _searchtest = TextEditingController();
  @override
  void initState() {
    context
        .read<ApiBloc>()
        .add(const GetResources(key: 'Category', value: 'YouTube Notes'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Youtube Notes',
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text("Youtube Notes not available"),
              //child: Text("Unable to get data"),
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

  Container _bodyWidget(List<BatchNotesDataModel> resources) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        SearchBarWidget(onChanged: (String value) {
          print(value);
        },),
        FractionallySizedBox(
          widthFactor: 0.95,
          child: ListView.builder(
            itemCount: resources.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _videoResourceWidget(
                resource: resources[index],
              );
            },
          ),
        )
      ]),
    );
  }

  Container _videoResourceWidget({required BatchNotesDataModel resource}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorResources.borderColor),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.network(SvgImages.pdfimage),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.title,
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ColorResources.gray),
                      ),
                      Text(
                        '2.5 MB',
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 10, color: ColorResources.gray),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Text(
                      'PDF',
                      style: GoogleFonts.notoSansDevanagari(
                          fontSize: 15,
                          color: ColorResources.buttoncolor,
                          fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.file_download_outlined,
                      size: 25,
                      color: ColorResources.buttoncolor,
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 135,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Watch on YouTube",
                    style: GoogleFonts.notoSansDevanagari(
                      color: ColorResources.textblack,
                      fontSize: 10,
                    ),
                  ),
                  Icon(
                    Icons.arrow_circle_right_rounded,
                    color: ColorResources.gray,
                    size: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
