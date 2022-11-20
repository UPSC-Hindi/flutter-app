
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_sources_impl.dart';
import 'package:upsc/features/data/remote/models/air_resource_model.dart';
import 'package:upsc/features/presentation/widgets/ResourcesPdfWidget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';

class AirResourcesScreen extends StatefulWidget {
  const AirResourcesScreen({Key? key, required this.resourceDataSourceImpl}) : super(key: key);
  final ResourceDataSourceImpl resourceDataSourceImpl;
  @override
  State<AirResourcesScreen> createState() => _AirResourcesScreenState();
}

class _AirResourcesScreenState extends State<AirResourcesScreen> {
  String? datetoshow;
  @override
  void initState() {
    super.initState();
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
      body: FutureBuilder<AirResourcesModel>(
          future: widget.resourceDataSourceImpl.getAir(),
          builder: (context,snapshots){
            if(ConnectionState.done == snapshots.connectionState){
              if(snapshots.hasData){
                AirResourcesModel? response = snapshots.data;
                if(response!.status){
                  return _bodyWidget(context, response.data);
                }else{
                  return Text(response.msg);
                }
              }else{
                return const Text('Server Error');
              }
            }else{
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  Container _bodyWidget(
      BuildContext context, List<AirResourcesDataModel> resources) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        const SizedBox(
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
              print( pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
              DateFormat('dd-MMMM-yyyy').format(pickedDate);
              print(formattedDate); //formatted date output using intl package =>  2021-03-16
              setState(() {
                datetoshow =  formattedDate; //set output date to TextField value.
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
              Icon(Icons.arrow_drop_down_outlined,
                  color: ColorResources.textWhite)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FractionallySizedBox(
          widthFactor: 0.90,
          child: ListView.builder(
            itemCount: resources.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ResourcesContainerWidget(
                title: resources[index].data, uploadFile: resources[index].audioFile,
              );
            },
          ),
        ),
      ]),
    );
  }
}