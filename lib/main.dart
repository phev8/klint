import 'package:flutter/material.dart';
import 'package:klint/state/persistent/app_state.dart';
import 'package:klint/state/persistent/storage.dart';
import 'package:klint/ui/pages/annotation_page/annotation_page.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:klint/ui/widgets/context_menu_injector.dart';
import 'package:klint/ui/widgets/mouse_provider.dart';
import 'package:provider/provider.dart';

import 'logic/config.dart';
import 'state/data/project_state.dart';

void main() async {
  await initialize();
  runApp(KLINT());
}

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  await Storage.initialize();
}

class KLINT extends StatelessWidget {
  Widget root() {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => AppState(),
        child: Selector<AppState, String>(
          selector: (_, appState) => appState.projectKey,
          builder: (context, projectKey, child) => ChangeNotifierProxyProvider0<ProjectState>(
            create: (context) => ProjectState(context, projectKey),
            update: (context, oldState) =>
                (oldState?.projectKey == projectKey) ? oldState! : ProjectState(context, projectKey),
            child: child,
          ),
          child: MouseProvider(
            child: ContextMenuInjector(
              child: AnnotationPage(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLINT',
      theme: KlintThemeData.materialTheme,
      home: root(),
    );
  }
}
