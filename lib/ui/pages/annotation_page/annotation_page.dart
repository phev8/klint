import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/annotation_shortcuts.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/state/persistent/app_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/ui/context_menus/tag_context_menu.dart';
import 'package:klint/ui/pages/annotation_page/components/annotation_bar/annotation_bar.dart';
import 'package:klint/ui/widgets/shortcuts_injector.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'components/annotation_view/annotation_view.dart';

class AnnotationPage extends StatelessWidget {
  Widget _annotationViewBuilder(context, projectState, markingDataState, child) {
    return ChangeNotifierProvider<AnnotationState>(
      create: (_) => AnnotationState(),
      child: ShortcutsInjector(
          shortcutsDefinition: AnnotationShortcuts(TagContextMenu(context, projectState, markingDataState)),
          child: child!),
    );
  }

  Widget _annotationView(BuildContext context) {
    return Expanded(
      child: Selector<AppState, Tuple3<String, String, String>>(
          selector: (_, appState) => Tuple3(appState.projectKey, appState.mediaCollection.id, appState.mediaKey),
          builder: (_, appStateKeys, __) => ChangeNotifierProxyProvider0<MarkingDataState>(
                create: (context) =>
                    MarkingDataState(context, appStateKeys.item1, appStateKeys.item2, appStateKeys.item3),
                update: (context, oldState) => (oldState?.projectKey == appStateKeys.item1 &&
                        oldState?.collectionKey == appStateKeys.item2 &&
                        oldState?.mediaKey == appStateKeys.item3)
                    ? oldState!
                    : MarkingDataState(context, appStateKeys.item1, appStateKeys.item2, appStateKeys.item3),
                builder: (_, __) => Consumer2<ProjectState, MarkingDataState>(
                  builder: _annotationViewBuilder,
                  child: AnnotationView(),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnnotationBarState>(
      create: (_) => AnnotationBarState(),
      child: Column(
        children: [
          AnnotationBar(),
          _annotationView(context),
        ],
      ),
    );
  }
}
