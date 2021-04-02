import 'package:flutter/material.dart';
import 'package:klint/ui/pages/annotation_page.dart';

void main() {
  runApp(KLINT());
}

class KLINT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLINT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnnotationPage(),
    );
  }
}
