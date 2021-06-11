import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/annotation_shortcuts.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/persistent/app_state.dart';
import 'package:klint/ui/widgets/annotation_view/annotation_view.dart';
import 'package:klint/ui/widgets/shortcuts_injector.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AnnotationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<AppState, Tuple3<String, String, String>>(
      selector: (_, appState) => Tuple3(appState.projectKey, appState.mediaCollection.id, appState.mediaKey),
      builder: (context, appStateKeys, child) => ChangeNotifierProxyProvider0<MarkingDataState>(
        create: (context) => MarkingDataState(context, appStateKeys.item1, appStateKeys.item2, appStateKeys.item3),
        update: (context, oldState) => (oldState?.projectKey == appStateKeys.item1 &&
                oldState?.collectionKey == appStateKeys.item2 &&
                oldState?.mediaKey == appStateKeys.item3)
            ? oldState!
            : MarkingDataState(context, appStateKeys.item1, appStateKeys.item2, appStateKeys.item3),
        child: child,
      ),
      child: ShortcutsInjector(
        shortcutsDefinition: AnnotationShortcuts(),
        child: AnnotationView(),
      ),
    );
  }
}
