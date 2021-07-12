import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: ()=>Navigator.pop(context),
      child: Container(
        color: Colors.pink,
      ),
    );
  }
}
