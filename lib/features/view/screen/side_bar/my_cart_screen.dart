import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/course_controller.dart';
import 'package:upsc_web/features/model/courses_model/CartCoursesModel.dart';
import 'package:upsc_web/features/view/widget/empty_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:upsc_web/utils/utils.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  int _selectedValue = 0;
  MyCartCoursesDataModel? cartSelectedItem;
  CoursesController coursesController = CoursesController();

  late Future<MyCartCoursesModel>getCartCourses;

  @override
  void initState() {
    getCartCourses = coursesController.getMyCartCourses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Languages.cart',
          style: Theme.of(context).textTheme.headline1,
      ),),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(Duration(seconds: 1)),
        child: FutureBuilder<MyCartCoursesModel>(
            future: getCartCourses,
            builder: (context,snapshots){
          if(snapshots.connectionState == ConnectionState.done){
            if(snapshots.hasData){
              if (snapshots.data!.data.isEmpty) {
                return EmptyWidget(
                  text: 'Your Cart is Empty!',
                  image: SvgImages.emptyCard,
                );
              }
              cartSelectedItem = snapshots.data!.data[_selectedValue];
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshots.data!.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RadioListTile(
                      contentPadding: EdgeInsets.only(right: 5.0),
                      value: index,
                      groupValue: _selectedValue,
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value as int;
                        });
                      },
                      title: _cartContainerWidget(
                        cartData: snapshots.data!.data[index],
                      ),
                    ),
                  ),
                  _bottomButtonWidget(snapshots.data!.data.first, context)
                ],
              );
            }else{
              return const Text('Unable to get cart courses');
            }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }),
      ),
    );
  }

  Stack _bottomButtonWidget(MyCartCoursesDataModel? cartData, BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${cartSelectedItem!.amount}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: const StadiumBorder()),
                    onPressed: makePayment,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: Text('Make Payment',
                          style: Theme.of(context).textTheme.headline2),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void makePayment() {
    if (cartSelectedItem != null) {
      // Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CoursePaymentScreen(
      //       course: cartSelectedItem!,
      //     ),
      //   ),
      // );
    } else {
      Utils.flutterToast('Select At least on item');
    }
  }

  // void removeFromCard(MyCartCoursesDataModel cartData) async {
  //   RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
  //   Preferences.onLoading(context);
  //   try {
  //     Response response =
  //     await remoteDataSourceImpl.deleteCartCourse(cartData.cartId);
  //     if (response.statusCode == 200) {
  //       _selectedValue = 0;
  //       if (!mounted) return;
  //       context.read<ApiBloc>().add(GetCartDetails());
  //     } else {
  //       flutterToast(response.data['msg']);
  //     }
  //   } catch (e) {
  //     flutterToast(e.toString());
  //   }
  //   if (!mounted) return;
  //   Preferences.hideDialog(context);
  // }

  Widget _cartContainerWidget({required MyCartCoursesDataModel cartData}) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorResources.textWhite,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Text(
                      cartData.batchDetails.batchName,
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.sensors_outlined,
                              color: ColorResources.buttoncolor,
                            ),
                            Text(
                              'Live lectures',
                              style:
                              GoogleFonts.notoSansDevanagari(fontSize: 8),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.signal_cellular_alt),
                            Text(
                              '100% Online',
                              style:
                              GoogleFonts.notoSansDevanagari(fontSize: 8),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.download),
                            Text(
                              'Downloadable',
                              style:
                              GoogleFonts.notoSansDevanagari(fontSize: 8),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorResources.buttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // removeFromCard(cartData);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text(Languages.remove),
                    ),
                  ),
                  Text(
                    '₹ ${cartData.amount}',
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
