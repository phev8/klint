import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class AnnotationBarItem extends StatelessWidget {
  final String text;
  final bool active;

  AnnotationBarItem(this.text, this.active);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KlintThemeData.defaultSpacing,
        vertical: KlintThemeData.defaultSpacing,
      ),
      child: Container(
        child: Text(text,
            style: active ? KlintThemeData.annotationBarSelectedTextStyle : KlintThemeData.annotationBarTextStyle),
      ),
    );
  }
}
