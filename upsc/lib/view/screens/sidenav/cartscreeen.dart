import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/course/coursePaymentScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedValue = 0;
  CartDataModel? cartSelectedItem;

  @override
  void initState() {
    context.read<ApiBloc>().add(GetCartDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.cart,
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(Duration(seconds: 1)),
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is ApiError) {
              return const Center(
                child: Text('Pls Refresh (or) Reopen App'),
              );
            }
            if (state is ApiCartDetailsSuccess) {
              if (state.cartData.isEmpty) {
                return EmptyWidget(
                  text: 'Your Cart is Empty!',
                  image: SvgImages.emptyCard,
                );
              }
              cartSelectedItem = state.cartData[_selectedValue];
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.cartData.length,
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
                        cartData: state.cartData[index],
                      ),
                    ),
                  ),
                  _bottomButtonWidget(state.cartData.first, context)
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Stack _bottomButtonWidget(CartDataModel? cartData, BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '???${cartSelectedItem!.amount}',
                  style: GoogleFonts.notoSansDevanagari(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: const StadiumBorder()),
                    onPressed: makePayment,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: Text(Languages.makePayment,
                          style: GoogleFonts.notoSansDevanagari(fontSize: 20)),
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
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoursePaymentScreen(
            course: cartSelectedItem!,
          ),
        ),
      );
    } else {
      flutterToast('Select At least on item');
    }
  }

  void removeFromCard(CartDataModel cartData) async {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    Preferences.onLoading(context);
    try {
      Response response =
          await remoteDataSourceImpl.deleteCartCourse(cartData.cartId);
      if (response.statusCode == 200) {
        _selectedValue = 0;
        if (!mounted) return;
        context.read<ApiBloc>().add(GetCartDetails());
      } else {
        flutterToast(response.data['msg']);
      }
    } catch (e) {
      flutterToast(e.toString());
    }
    if (!mounted) return;
    Preferences.hideDialog(context);
  }

  Widget _cartContainerWidget({required CartDataModel cartData}) {
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
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.textblack,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
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
                      removeFromCard(cartData);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text(Languages.remove),
                    ),
                  ),
                  Text(
                    '??? ${cartData.amount}',
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
