import 'package:flutter/material.dart';
import 'package:klint/state/persistent/app_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/ui/pages/annotation_page/components/annotation_bar/components/annotation_bar_item.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:provider/provider.dart';

class AnnotationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: KlintThemeData.menuBackgroundColor,
      child: Consumer<AnnotationBarState>(
        builder: (context, state, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnnotationBarItem(context.read<AppState>().mediaKey, false),
              AnnotationBarItem(" | ", true),
              AnnotationBarItem("(B)ox", state.box),
              AnnotationBarItem("(C)lasses", state.classes),
              AnnotationBarItem("(T)ags", state.tags),
              AnnotationBarItem("(S)ave", state.save),
              AnnotationBarItem("(D)elete", state.delete),
              AnnotationBarItem("(J)ump To", false),
              AnnotationBarItem("(R)eload", false)
            ],
          );
        },
      ),
    );
  }
}
