import 'package:flutter/material.dart';
import 'package:klint/ui/pages/annotation_page.dart';
import 'package:klint/ui/widgets/context_menu_injector.dart';
import 'package:klint/ui/widgets/mouse_provider.dart';

import 'logic/config.dart';

void main() async {
  await initialize();
  runApp(KLINT());
}

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  // await Storage.initialize();
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
