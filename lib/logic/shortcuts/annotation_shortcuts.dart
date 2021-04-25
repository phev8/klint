import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/api/entities/marking_class.dart';
import 'package:klint/api/entities/project.dart';
import 'package:klint/api/entities/project_container.dart';
import 'package:klint/api/entities/tag_marking_option.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  AnnotationShortcuts(BuildContext getContext())
      : super(
          <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.keyT): const _TagIntent(),
            LogicalKeySet(LogicalKeyboardKey.keyD): const _DebugIntent(),
          },
          <Type, Action<Intent>>{
            _TagIntent: CallbackAction<_TagIntent>(onInvoke: (_TagIntent intent) {
              getContext().read<ContextMenuState>().openDebugMenu(getContext());
              return;
            }),
            _DebugIntent: CallbackAction<_DebugIntent>(onInvoke: (_DebugIntent intent) async {
              await Api.call(
                getContext(),
                () => ProjectsApi.putProject(
                  "test2",
                  Project(
                    "TestProject",
                    ProjectMediaType.IMAGES,
                    [MarkingClass("car", "Car", MarkingScope.OBJECTS)],
                    [
                      TagMarkingOption("dlvl", "Danger Level", "", ["Low", "Medium", "High"], true)
                    ],
                  ),
                ),
              );

              // await Api.call(getContext(), () => ProjectsApi.deleteProject("0"));

              Api.call(getContext(), ProjectsApi.getAllProjects, onSuccess: (response) {
                response.data.forEach((element) {
                  print(ProjectContainer.fromJson(element).toJson());
                });
              });
              return;
            }),
          },
        );
}

class _TagIntent extends Intent {
  const _TagIntent();
}

class _DebugIntent extends Intent {
  const _DebugIntent();
}
