import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class TapableOverlay extends StatelessWidget {
  final Function()? onTap;

  const TapableOverlay({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: KlintThemeData.overlayColor,
        ));
  }
}
