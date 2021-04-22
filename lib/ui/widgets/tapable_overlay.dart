import 'package:flutter/material.dart';

class TapableOverlay extends StatelessWidget {
  final Function()? onTap;

  const TapableOverlay({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ));
  }
}
