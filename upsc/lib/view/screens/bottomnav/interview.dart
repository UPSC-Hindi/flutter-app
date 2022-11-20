import 'package:flutter/material.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InterviewScreen'),
      ),
      body: const Center(
        child: Text('InterviewScreen'),
      ),
    );
  }
}
