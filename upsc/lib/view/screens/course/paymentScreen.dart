import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upsc/view/screens/sidenav/mycourses.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 1500), () {
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) =>const MyCoursesScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Thank You!',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
