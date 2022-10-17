
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class ResourcesPdfWidget extends StatelessWidget {
  const ResourcesPdfWidget({Key? key, required this.resource}) : super(key: key);
  final ResourcesDataModel resource;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorResources.borderColor),
      ),
      padding: const EdgeInsets.all(10),
      margin:const EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
                    resource.title!,
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500,color: ColorResources.gray),
                  ),
                  Text(
                    '2.5 MB',
                    style: GoogleFonts.poppins(
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
                Text('PDF',style: TextStyle(
                    fontSize: 15,
                    color: ColorResources.buttoncolor,
                    fontWeight: FontWeight.w700
                ),),
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
    );
  }
}