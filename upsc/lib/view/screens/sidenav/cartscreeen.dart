import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  CartDataModel cartSelectedItem = CartDataModel(
    cartId: '',
    createdAt: DateTime.now(),
    amount: '0.00',
    isActive: false,
    batchDetails: [],
  );

  @override
  Widget build(BuildContext context) {
    context.read<ApiBloc>().add(GetCartDetails());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.cart,
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
          if (state is ApiCartDetailsSuccess) {
            if (state.cartData.isEmpty) {
              return EmptyWidget(
                text: 'Your Cart is Empty!',
                image: SvgImages.emptyCard,
              );
            }
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.cartData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CartContainerWidget(
                    cartData: state.cartData[index],
                    selectedCartCourse: (CartDataModel selectedCart) {
                      setState(() {
                        cartSelectedItem = selectedCart;
                      });
                    },
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
                  '₹${cartSelectedItem.amount}',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      if (cartSelectedItem.amount != "0.00") {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoursePaymentScreen(
                              course: cartSelectedItem,
                            ),
                          ),
                        );
                      } else {
                        flutterToast('Select At least on item');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: Text('Make Payment',
                          style: GoogleFonts.poppins(fontSize: 20)),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CartContainerWidget extends StatefulWidget {
  const CartContainerWidget(
      {Key? key, required this.cartData, required this.selectedCartCourse})
      : super(key: key);
  final CartDataModel cartData;
  final Function(CartDataModel) selectedCartCourse;

  @override
  State<CartContainerWidget> createState() => _CartContainerWidgetState();
}

class _CartContainerWidgetState extends State<CartContainerWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          widget.selectedCartCourse(widget.cartData);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 100,
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? Colors.red.shade50 : ColorResources.textWhite,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.cartData.batchDetails['batch_name'],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.sensors_outlined,
                                    color: ColorResources.buttoncolor,
                                  ),
                                  Text(
                                    'Live lectures',
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                              Column(
                                children: const [
                                  Icon(Icons.signal_cellular_alt),
                                  Text(
                                    '100% Online',
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                              Column(
                                children: const [
                                  Icon(Icons.download),
                                  Text(
                                    'Downloadable',
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        RemoteDataSourceImpl remoteDataSourceImpl =
                            RemoteDataSourceImpl();
                        Preferences.onLoading(context);
                        try {
                          Response response = await remoteDataSourceImpl
                              .deleteCartCourse(widget.cartData.cartId);
                          if (response.statusCode == 200) {
                            context.read<ApiBloc>().add(GetCartDetails());
                          } else {
                            flutterToast(response.data['msg']);
                          }
                        } catch (e) {
                          print(e);
                          flutterToast(e.toString());
                        }
                        Preferences.hideDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: Text(Languages.remove),
                      ),
                    ),
                    Text(
                      '₹ ${widget.cartData.amount}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
