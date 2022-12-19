import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:upsc_web/features/controller/global_controller.dart';
import 'package:upsc_web/features/model/courses_model/CartCoursesModel.dart';
import 'package:upsc_web/features/model/payment_model/order_id_model.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/remote_services.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/utils.dart';

const String razorPayId = 'rzp_test_CWt1qviQEvI8wW';

class CoursePaymentScreen extends StatefulWidget {
  const CoursePaymentScreen({Key? key, required this.course}) : super(key: key);
  final MyCartCoursesDataModel course;

  @override
  State<CoursePaymentScreen> createState() => _CoursePaymentScreenState();
}

class _CoursePaymentScreenState extends State<CoursePaymentScreen> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String key, String orderId) async {
    print('*' * 2000);
    print(razorPayId);
    print(key.toString());
    var options = {
      'key': key,
      //"order_id": orderId,
      'amount': (100 * int.parse(widget.course.amount) -
              (100 *
                  (int.parse(widget.course.amount) *
                      (int.parse(widget.course.batchDetails.discount) / 100))))
          .toString(),
      'name': widget.course.batchDetails.batchName,
      'description': "upschindi",
      'prefill': {
        'contact': PreferencesHelper.getString(Preferences.phoneNUmber),
        'email': PreferencesHelper.getString(Preferences.email),
      },
      //'timeout': 180,
      //"currency": "INR",
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("-----Payment Success-----");
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    Utils.flutterToast(
        "SUCCESS: ${response.orderId} ${response.paymentId} ${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("-----Payment error-----");
    Utils.flutterToast("ERROR: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.flutterToast("SUCCESS: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CarouselSlider(
              //   items: images,
              //   options: CarouselOptions(
              //     viewportFraction: 1,
              //     initialPage: 0,
              //     enableInfiniteScroll: true,
              //     reverse: false,
              //     autoPlay: true,
              //     autoPlayInterval: const Duration(seconds: 3),
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enlargeCenterPage: true,
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.course.batchDetails.batchName,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '${widget.course.amount} INR',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    ' (include tax)',
                    style: GoogleFonts.notoSansDevanagari(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.course.amount,
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              int.parse(widget.course.batchDetails.discount) != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'discount',
                          style: GoogleFonts.notoSansDevanagari(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          (int.parse(widget.course.amount) *
                                  (int.parse(
                                          widget.course.batchDetails.discount) /
                                      100))
                              .round()
                              .toString(),
                          style: GoogleFonts.notoSansDevanagari(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    )
                  : Text(''),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payable Amount',
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    (int.parse(widget.course.amount) -
                            ((int.parse(widget.course.amount) *
                                (int.parse(
                                        widget.course.batchDetails.discount) /
                                    100))))
                        .round()
                        .toString(),
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: ColorResources.buttoncolor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      getOrderId({'amount': widget.course.amount});
                    },
                    child: Text(
                      'Checkout',
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      web: Text('It is not build'),
      tab: Text('It is not build'),
    );
  }

  getOrderId(dynamic data) async {
    try {
      Response response = await RemoteServices.getOrderIdService(data);
      print(response);
      //OrderIdGeneration resp = OrderIdGeneration.fromJson(response);
      if (response.statusCode == 200) {
        openCheckout(response.data["key_id"], response.data["id"]);
      }
    } catch (error) {
      rethrow;
    }
  }
}
