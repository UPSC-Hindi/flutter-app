import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/images_file.dart';

class DailyNewsScreen extends StatefulWidget {
  const DailyNewsScreen({Key? key}) : super(key: key);

  @override
  State<DailyNewsScreen> createState() => _DailyNewsScreenState();
}

class _DailyNewsScreenState extends State<DailyNewsScreen> {
  String? datetoshow;

  @override
  void initState() {
    super.initState();
    context
        .read<ApiBloc>()
        .add(const GetResources(key: 'Category', value: 'Daily News'));
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Daily News',
          style: GoogleFonts.poppins(
            color: ColorResources.textblack,
            fontWeight: FontWeight.w500,
          ),
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
            if (state.resources.data!.isEmpty) {
              return const Center(
                child: Text('There is no resources'),
              );
            }
            return _bodyWidget(context, state.resources.data!);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container _bodyWidget(
      BuildContext context, List<ResourcesDataModel> resources) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Text(
            datetoshow == DateFormat('dd-MMMM-yyyy').format(DateTime.now())
                ? 'News for Today'
                : "News for",
            style: GoogleFonts.poppins(
                color: ColorResources.textblack,
                fontWeight: FontWeight.w500,
                fontSize: 20)),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: ColorResources.buttoncolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100));
            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('dd-MMMM-yyyy').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              setState(() {
                datetoshow =
                    formattedDate; //set output date to TextField value.
              });
            } else {}
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$datetoshow',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.textWhite),
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: ColorResources.textWhite)
              
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FractionallySizedBox(
            widthFactor: 0.90,
            child: ListView.builder(
                itemCount: resources.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _dailyNewsResourceWidget(resources[index]);
                }))
      ]),
    );
  }

  Column _dailyNewsResourceWidget(ResourcesDataModel resource) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.network(SvgImages.pdfimage),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.title!,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '2.5 MB',
                        style: GoogleFonts.lato(
                            fontSize: 16, color: ColorResources.gray),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.file_download_outlined,
                  size: 40,
                  color: ColorResources.buttoncolor,
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
