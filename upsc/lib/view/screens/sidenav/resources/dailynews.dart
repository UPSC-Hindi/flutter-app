import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/daily_news_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';

class DailyNewsScreen extends StatefulWidget {
  const DailyNewsScreen({Key? key, required this.resourceDataSourceImpl})
      : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;

  @override
  State<DailyNewsScreen> createState() => _DailyNewsScreenState();
}

class _DailyNewsScreenState extends State<DailyNewsScreen> {
  String? datetoshow;

  List<DailyNewsDataModel> listdata = [];

  @override
  void initState() {
    super.initState();
    datetoshow = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Daily News',
          style: GoogleFonts.notoSansDevanagari(
            color: ColorResources.textblack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<DailyNewsModel>(
          future: widget.resourceDataSourceImpl.getDailyNews(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                DailyNewsModel? response = snapshots.data;
                if (response!.status) {
                  print(response.data[0].createdAt);
                  response.data.sort(
                    (a, b) {
                      return a.createdAt.compareTo(b.createdAt);
                    },
                  );
                  response.data.forEach(
                    (element) {
                      if (DateFormat("dd-MM-yyyy")
                              .parse(element.createdAt)
                              .toString()
                              .split(" ")[0] ==
                          DateFormat("dd-MM-yyyy")
                              .parse(datetoshow!)
                              .toString()
                              .split(" ")[0]) {
                        listdata.add(element);
                        print('------found u---------');
                      }
                    },
                  );
                  return _bodyWidget(context, listdata);
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

  Container _bodyWidget(
      BuildContext context, List<DailyNewsDataModel> resources) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Text(
              datetoshow == DateFormat('dd-MM-yyyy').format(DateTime.now())
                  ? 'News for Today'
                  : "News for",
              style: GoogleFonts.notoSansDevanagari(
                  color: ColorResources.textblack,
                  fontWeight: FontWeight.w500,
                  fontSize: 20)),
          const SizedBox(
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
                    DateFormat('dd-MM-yyyy').format(pickedDate);
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
                  DateFormat('dd-MMMM-yyyy')
                      .format(DateFormat('dd-MM-yyyy').parse(datetoshow!)),
                  style: GoogleFonts.notoSansDevanagari(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.textWhite),
                ),
                Icon(Icons.arrow_drop_down_outlined,
                    color: ColorResources.textWhite)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          resources.isEmpty
              ? const Center(
                  child: Text('No news avilable for select date'),
                )
              : FractionallySizedBox(
                  widthFactor: 0.90,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
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
        ]),
      ),
    );
  }
}
