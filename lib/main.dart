import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/media_collection.dart';
import 'package:klint/api/entities/project_container.dart';
import 'package:klint/state/persistent/annotation_screen_state.dart';
import 'package:klint/state/persistent/storage.dart';
import 'package:klint/ui/pages/annotation_page/annotation_page.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:klint/ui/widgets/context_menu_injector.dart';
import 'package:klint/ui/widgets/mouse_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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

class AnnotationScreen extends StatelessWidget {
  const AnnotationScreen({Key? key}) : super(key: key);

  Widget build(BuildContext buildContext) {
    return ChangeNotifierProvider(
        create: (_) => AnnotationScreenState(),
        child: Consumer<AnnotationScreenState>(builder: (context, annotationScreenState, _) {
          return ChangeNotifierProvider(
              create: (_) => ProjectState(buildContext, annotationScreenState.projectKey),
              child: Scaffold(
                  body: MouseProvider(
                child: ContextMenuInjector(
                  child: AnnotationPage(),
                ),
              )));
        }));
  }

/*   Widget buildOld(BuildContext buildContext) {
    return ChangeNotifierProvider(
        create: (_) => AnnotationScreenState(),
        child: Consumer<AnnotationScreenState>(builder: (context, annotationScreenState, _) {
          return Scaffold(
            body: Selector<AnnotationScreenState, String>(
              selector: (_, annotationScreenState) => annotationScreenState.projectKey,
              builder: (context, projectKey, child) => ChangeNotifierProxyProvider0<ProjectState>(
                create: (context) => ProjectState(context, projectKey),
                update: (context, oldState) => (oldState?.projectKey == projectKey) ? oldState! : ProjectState(context, projectKey),
                child: child,
              ),
              child: MouseProvider(
                child: ContextMenuInjector(
                  child: AnnotationPage(),
                ),
              ),
            ),
          );
        }));
  } */
}

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool hasLoaded = false;
  List<Tuple2<String, MediaCollection>> projectsAndCollections = List.empty(growable: true);

  @override
  Widget build(BuildContext buildContext) {
    if (!hasLoaded) {
      loadAvailableCollections(buildContext);
      hasLoaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Collection'),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: projectsAndCollections.length,
        itemBuilder: (buildContext, index) {
          Tuple2<String, MediaCollection> pIdcId = projectsAndCollections[index];
          return OutlinedButton(
            child: Text(pIdcId.item1 + " | " + pIdcId.item2.id),
            onPressed: () {
              openAnnotationScreen(buildContext, pIdcId.item1, pIdcId.item2);
            },
          );
        },
      )),
    );
  }

  loadAvailableCollections(BuildContext buildContext) {
    Api.call(buildContext, () => ProjectsApi.getAllProjects(), onSuccess: (response) {
      if (response.data != null) {
        List<Tuple2<String, MediaCollection>> availableCollections = List.empty(growable: true);
        for (Map<String, dynamic> projectJSON in response.data) {
          //print(projectJSON);
          try {
            ProjectContainer pc = ProjectContainer.fromJson(projectJSON);
            for (var collection in pc.value.mediaCollections) {
              availableCollections.add(Tuple2<String, MediaCollection>(pc.key, collection));
              //print(Tuple2(pc.key, collection));
            }
          } catch (e) {
            print(e);
          }
        }
        setState(() {
          projectsAndCollections = availableCollections;
          hasLoaded = true;
        });
      }
    });
  }

  openAnnotationScreen(BuildContext buildContext, String projectKey, MediaCollection mediaCollection) {
    Storage.projectKey = projectKey;
    Storage.mediaCollection = mediaCollection;
    Api.call(buildContext, () => ProjectsApi.getAllProjectFiles(projectKey, mediaCollection.id), onSuccess: (response) {
      List<dynamic> mediaKeys = jsonDecode(response.data.toString());
      if (response.data != null && mediaKeys.length > 0) {
        //print(mediaKeys);
        //print(Storage.mediaKey);
        if (!mediaKeys.contains(Storage.mediaKey)) {
          Storage.mediaKey = mediaKeys[0];
        }
        Navigator.push(
            buildContext,
            MaterialPageRoute(
              builder: (context) => AnnotationScreen(),
            ));
      }
    });
  }
}

class KLINT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLINT',
      theme: KlintThemeData.materialTheme,
      home: SelectionScreen(),
    );
  }
}
