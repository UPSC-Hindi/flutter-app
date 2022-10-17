import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key, required this.image, required this.text,
  }) : super(key: key);
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(image),
          const SizedBox(height: 30,),
          Text(text,style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Colors.black.withOpacity(0.3),
          ),),
        ],
      ),
    );
  }
}