import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/myorders_model.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          Languages.myOrders,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<MyOrdersModel>(
          future: remoteDataSourceImpl.getMyOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.status) {
                  List<MyOrderDataModel> ordersList = snapshot.data!.data;
                  if (ordersList.isEmpty) {
                    return EmptyWidget(
                      text: 'There are no Orders',
                      image: SvgImages.emptyCard,
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: ordersList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _myCoursesCardWidget(
                          context,
                          ordersList[index],
                        ),
                      ),
                    );
                  }
                } else {
                  return Text(snapshot.data!.msg);
                }
              } else {
                return const Text('Something went wrong');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Center _myCoursesCardWidget(BuildContext context, MyOrderDataModel myOrders) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Text(
                      myOrders.batchName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSansDevanagari(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Text(
                    "₹ ${myOrders.amount}",
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 20, color: ColorResources.textblack),
                  ),
                ],
              ),
              myOrders.success
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${myOrders.transactionDate}',
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack),
                        ),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            flutterToast("pls wait downloading invoice");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'view',
                                style: GoogleFonts.notoSansDevanagari(
                                    color: ColorResources.textWhite),
                              ), // <-- Text
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: ColorResources.textWhite),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${myOrders.transactionDate}',
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("cartscreen");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Re-try',
                                style: GoogleFonts.notoSansDevanagari(
                                    color: ColorResources.textWhite),
                              ), // <-- Text
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: ColorResources.textWhite),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
