import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Size get preferredSize => const Size.fromHeight(400.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox.fromSize(
          size: preferredSize,
          child: LayoutBuilder(builder: (context, constraint) {
            final width = constraint.maxWidth * 8;
            return ClipRect(
              child: OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: SizedBox(
                  width: width,
                  height: width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: width * 0.80 - preferredSize.height * 0.60),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black54, blurRadius: 10.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Center(
          child: Text('ContactUsScreen'),
        ),
      ]),
    );
  }
}
