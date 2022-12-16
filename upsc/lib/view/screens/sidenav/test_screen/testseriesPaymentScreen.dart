import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/payment_model.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/Test_series/testSerie.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/models/orderIdgeneration.dart';
import 'package:upsc/util/appString..dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/course/paymentScreen.dart';

class TestPaymentScreen extends StatefulWidget {
  final TestSeriesData testseries;
  const TestPaymentScreen({Key? key, required this.testseries})
      : super(key: key);

  @override
  State<TestPaymentScreen> createState() => _TestPaymentScreenState();
}

class _TestPaymentScreenState extends State<TestPaymentScreen> {
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("-----Payment Success-----");
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    Fluttertoast.showToast(
        msg:
            "SUCCESS: ${response.orderId} ${response.paymentId} ${response.signature}");
    Map<String, dynamic> body = {
      "orderId": '',
      "userpaymentOrderId": response.orderId!,
      "paymentId": response.paymentId!.toString(),
      "description": "upschindi",
      "mobileNumber": mobileNumber!,
      "userName": userName!,
      "userEmail": userEmail!,
      "Signature": response.signature!,
      "TestSeriesId": widget.testseries.sId!,
      "price": (int.parse(widget.testseries.charges!) -
              ((int.parse(widget.testseries.charges!) *
                  (int.parse(widget.testseries.discount!) / 100))))
          .round()
          .toString(),
      "success": true.toString()
    };
    _savePaymentStatus(body,true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("-----Payment error-----");
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}");
    Map<String, dynamic> body = {
       "orderId": '',
        "userpaymentOrderId": '',
        "paymentId": '',
        "description": "",
        "mobileNumber": mobileNumber!,
        "userName": userName!,
        "userEmail": userEmail!,
        "Signature": '',
        "TestSeriesId": widget.testseries.sId!,
        "price": (int.parse(widget.testseries.charges!) -
                ((int.parse(widget.testseries.charges!) *
                    (int.parse(widget.testseries.discount!) / 100))))
            .round()
            .toString(),
        "success": false.toString()
    };
    _savePaymentStatus(body,false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("-----Payment Success W-----");
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName!}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
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
              widget.testseries.testseriesName!,
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
                  '${widget.testseries.charges!} INR',
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
                  widget.testseries.charges!,
                  style: GoogleFonts.notoSansDevanagari(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            int.parse(widget.testseries.discount!) != 0
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
                        (int.parse(widget.testseries.charges!) *
                                (int.parse(widget.testseries.discount!) / 100))
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
                  (int.parse(widget.testseries.charges!) -
                          ((int.parse(widget.testseries.charges!) *
                              (int.parse(widget.testseries.discount!) / 100))))
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
                    callApiorderid(widget.testseries.sId);
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
      "amount": (int.parse(widget.testseries.charges!) -
              ((int.parse(widget.testseries.charges!) *
                  (int.parse(widget.testseries.discount!) / 100))))
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
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
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

  void openCheckout(id, razorpaykey) async {
    print('*' * 2000);
    print(razorpaykey);
    print(id.toString());
    var options = {
      'key': razorpaykey,
      "order_id": id,
      'amount': (100 * int.parse(widget.testseries.charges!) -
              (100 *
                  (int.parse(widget.testseries.charges!) *
                      (int.parse(widget.testseries.discount!) / 100))))
          .toString(),
      'name': widget.testseries.testseriesName,
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

  void _savePaymentStatus( Map<String, dynamic> paymentData,bool status) async {
    print("----Saving Payment Details -----");
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    Map<String, dynamic> body = paymentData;
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      print("----Saving Payment Details -----");
      Response response =
          await remoteDataSourceImpl.savetestPaymentStatus(body);
      print("----Saving Payment Details -----");
      if (response.statusCode == 200) {
        print("----Saving Payment Details -----");
        print(response.data);
        flutterToast(response.data['msg']);
        setState(() {
          Preferences.hideDialog(context);
        });
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(paymentfor: "test",status: status),
          ),
        );
      } else {
        print("-----api Payment error -----");
        setState(() {
          Preferences.hideDialog(context);
        });
        flutterToast("Pls Refresh (or) Reopen App");
      }
    } catch (error) {
      print(error);
      setState(() {
        Preferences.hideDialog(context);
      });
      flutterToast(error.toString());
    }
  }
}
