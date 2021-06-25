import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class TileTitle extends StatelessWidget {
  final String text;

  TileTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: KlintThemeData.tileTitleOffset,
      child: Text(text, style: KlintThemeData.tileTitleTextStyle),
    );
  }
}
