import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9, child: Container(width: 16, height: 9));
  }
}
