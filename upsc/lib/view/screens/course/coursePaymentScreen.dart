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
import 'package:upsc/models/orderIdgeneration.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
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
  @override
  void initState() {
    super.initState();
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

  void openCheckout(id) async {
    print('*' * 2000);
    print(id.toString());
    var options = {
      'key': razorPayId,
      "order_id": id,
      'amount': (100 * int.parse(widget.course.amount)).toString(),
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
    Fluttertoast.showToast(
        msg:
            "SUCCESS: ${response.orderId} ${response.paymentId} ${response.signature}");
    _savePaymentStatus(PaymentModel(
        orderId: '',
        userpaymentOrderId: response.orderId!,
        paymentId: response.paymentId!.toString(),
        description: "upschindi",
        mobileNumber: mobileNumber!,
        userName: userName!,
        userEmail: userEmail!,
        Signature: response.signature!,
        batchId: widget.course.batchDetails.id,
        price: widget.course.amount,
        success: true));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("-----Payment error-----");
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}");
    _savePaymentStatus(PaymentModel(
        orderId: '',
        userpaymentOrderId: '',
        paymentId: '',
        description: "",
        mobileNumber: mobileNumber!,
        userName: userName!,
        userEmail: userEmail!,
        Signature: '',
        batchId: widget.course.batchDetails.id,
        price: widget.course.amount,
        success: false));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("-----Payment Success W-----");
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName!}");
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
              items: [
                Image.network(SvgImages.banner_1),
                // SvgPicture.asset(SvgImages.banner_1,),
                Image.network(SvgImages.banner_2),
                // SvgPicture.asset(SvgImages.banner_2),
                Image.network(SvgImages.banner_3),
                // SvgPicture.asset(SvgImages.banner_3),
                Image.network(SvgImages.banner_4),
                // SvgPicture.asset(SvgImages.banner_4),
              ],
              options: CarouselOptions(
                height: 250,
                aspectRatio: 16 / 9,
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
            Text(widget.course.batchDetails.batchName),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${widget.course.amount} INR',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  widget.course.amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tax',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '120.40',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
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
                const Text(
                  'Payable Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  widget.course.amount,
                  style: const TextStyle(
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
                    style: GoogleFonts.poppins(
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
      "batch_id": id,
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
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
        openCheckout(response.data!.orderId.toString());
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

  void _savePaymentStatus(PaymentModel paymentData) async {
    print("----Saving Payment Details -----");
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    Preferences.onLoading(context);
    try {
      Response response =
          await remoteDataSourceImpl.savePaymentStatus(paymentData);
      if (response.statusCode == 200) {
        flutterToast(response.data['msg']);
        Preferences.hideDialog(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentScreen(),
          ),
        );
      } else {
        print("-----api Payment error -----");
        Preferences.onLoading(context);
        flutterToast("Something went wrong");
      }
    } catch (error) {
      print(error);
      flutterToast(error.toString());
    }
  }
}
