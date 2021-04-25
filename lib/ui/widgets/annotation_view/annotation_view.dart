import 'package:flutter/material.dart';
import 'package:klint/ui/widgets/annotation_view/components/annotations_overlay/annotations_overlay.dart';

import '../mouse_provider.dart';
import 'components/frame/frame.dart';

class AnnotationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseProvider(
      child: AnnotationsOverlay(
        frame: Frame(),
      ),
    );
  }
}
