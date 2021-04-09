import 'package:flutter/material.dart';
import 'package:klint/ui/pages/annotation_page.dart';
import 'package:klint/ui/widgets/context_menu_injector.dart';
import 'package:klint/ui/widgets/mouse_provider.dart';

void main() {
  runApp(KLINT());
}

class KLINT extends StatelessWidget {
  Widget root() {
    return MouseProvider(
      child: ContextMenuInjector(
        child: AnnotationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLINT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: root(),
    );
  }
}
