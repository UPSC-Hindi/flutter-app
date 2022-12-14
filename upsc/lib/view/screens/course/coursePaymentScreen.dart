import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/payment_model.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/models/orderIdgeneration.dart';
import 'package:upsc/util/appString..dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/course/paymentScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

const String razorPayId = 'rzp_test_CWt1qviQEvI8wW';

class CoursePaymentScreen extends StatefulWidget {
  const CoursePaymentScreen({Key? key, required this.course}) : super(key: key);
  final CartDataModel course;

  @override
  State<CoursePaymentScreen> createState() => _CoursePaymentScreenState();
}

class _CoursePaymentScreenState extends State<CoursePaymentScreen> {
  final Razorpay _razorpay = Razorpay();
  String? mobileNumber;
  String? userName;
  String? userEmail;
  List<Widget> images = [];
  @override
  void initState() {
    super.initState();
    callApigetbanner();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getUserInfo();
  }

  void getUserInfo() {
    mobileNumber = SharedPreferenceHelper.getString(Preferences.phoneNUmber)!;
    userName = SharedPreferenceHelper.getString(Preferences.name)!;
    userEmail = SharedPreferenceHelper.getString(Preferences.email)!;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(id, razorpaykey) async {
    print('*' * 2000);
    print(razorpaykey);
    print(id.toString());
    var options = {
      'key': razorPayId,
      "order_id": id,
      'amount': (100 * int.parse(widget.course.amount) -
              (100 *
                  (int.parse(widget.course.amount) *
                      (int.parse(widget.course.batchDetails.discount) / 100))))
          .toString(),
      'name': widget.course.batchDetails.batchName,
      'description': "upschindi",
      'prefill': {'contact': mobileNumber, 'email': userEmail},
      "notify": {"sms": true, "email": true},
      'timeout': 180,
      "currency": "INR",
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("-----Payment Success-----");
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    // Fluttertoast.showToast(
    //     msg:
    //         "SUCCESS: ${response.orderId} ${response.paymentId} ${response.signature}");
    _savePaymentStatus(
        PaymentModel(
            orderId: '',
            userpaymentOrderId: response.orderId!,
            paymentId: response.paymentId!.toString(),
            description: "upschindi",
            mobileNumber: mobileNumber!,
            userName: userName!,
            userEmail: userEmail!,
            Signature: response.signature!,
            batchId: widget.course.batchDetails.id,
            price: (int.parse(widget.course.amount) -
                    ((int.parse(widget.course.amount) *
                        (int.parse(widget.course.batchDetails.discount) /
                            100))))
                .round()
                .toString(),
            success: true.toString()),
        true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("-----Payment error-----");
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}");
    _savePaymentStatus(
        PaymentModel(
            orderId: '',
            userpaymentOrderId: '',
            paymentId: '',
            description: "",
            mobileNumber: mobileNumber!,
            userName: userName!,
            userEmail: userEmail!,
            Signature: '',
            batchId: widget.course.batchDetails.id,
            price: (int.parse(widget.course.amount) -
                    ((int.parse(widget.course.amount) *
                        (int.parse(widget.course.batchDetails.discount) /
                            100))))
                .round()
                .toString(),
            success: false.toString()),
        false);
  }

  Future<BaseModel<getbannerdetails>> callApigetbanner() async {
    getbannerdetails response;
    try {
      response = await RestClient(RetroApi2().dioData2()).bannerimagesRequest();
      print(response.msg);
      for (var entry in response.data!) {
        for (String image in entry.bannerUrl!) {
          images.add(Image.network(image));
        }
      }
      setState(() {});
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("-----Payment Success W-----");
    // Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName!}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: images,
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.course.batchDetails.batchName,
              style: GoogleFonts.notoSansDevanagari(
                fontSize: Fontsize().h2,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '${widget.course.amount} INR',
                  style: GoogleFonts.notoSansDevanagari(
                    fontWeight: FontWeight.w900,
                  ),
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
                              (int.parse(widget.course.batchDetails.discount) /
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
                    borderRadius: BorderRadius.circular(14)),
                child: TextButton(
                  onPressed: () {
                    callApiorderid(widget.course.batchDetails.id);
                    //openCheckout(widget.course.batchDetails.id);
                    //checkOutButton(context);
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
    );
  }

  Future<BaseModel<OrderIdGeneration>> callApiorderid(id) async {
    OrderIdGeneration response;
    Map<String, dynamic> body = {
      "amount": (int.parse(widget.course.amount) -
              ((int.parse(widget.course.amount) *
                  (int.parse(widget.course.batchDetails.discount) / 100))))
          .round(),
      // "name": SharedPreferenceHelper.getString(Preferences.name),
      // "email": SharedPreferenceHelper.getString(Preferences.email),
      // "mobileNumber": SharedPreferenceHelper.getString(Preferences.phoneNUmber),
      // "description": "upschindi",
      // "transactionId": '123',
      // "transactiondate": DateTime.now().toString(),
      //"batch_id": id,
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      var token = SharedPreferenceHelper.getString(Preferences.access_token);
      response =
          await RestClient(RetroApi().dioData(token!)).getorderidRequest(body);
      if (response.status!) {
        setState(() {
          Preferences.hideDialog(context);
        });
        // Fluttertoast.showToast(
        //   msg: '${response.msg}',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: ColorResources.gray,
        //   textColor: ColorResources.textWhite,
        // );
        openCheckout(response.id, response.keyId);
      } else {
        setState(() {
          Preferences.hideDialog(context);
        });
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  void _savePaymentStatus(PaymentModel paymentData, bool status) async {
    print("----Saving Payment Details -----");
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    Preferences.onLoading(context);
    try {
      Response response =
          await remoteDataSourceImpl.savePaymentStatus(paymentData);
      if (response.statusCode == 200) {
        print(response.data);
        flutterToast(response.data['msg']);
        Preferences.hideDialog(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              paymentfor: "course",
              status: status,
            ),
          ),
        );
      } else {
        print("-----api Payment error -----");
        Preferences.onLoading(context);
        flutterToast("Pls Refresh (or) Reopen App");
      }
    } catch (error) {
      print(error);
      flutterToast(error.toString());
    }
  }
}
