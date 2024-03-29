import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/state/persistent/annotation_screen_state.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:provider/provider.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  Response? mediaResponse;
  String? projectKey;
  String? mediaCollectionId;
  String? mediaKey;

  Future<Response?> getMediaResponse(BuildContext context, AnnotationScreenState state) async {
    if (mediaResponse != null &&
        projectKey == state.projectKey &&
        mediaCollectionId == state.mediaCollection.id &&
        mediaKey == state.mediaKey) {
      return mediaResponse;
    }

    projectKey = state.projectKey;
    mediaCollectionId = state.mediaCollection.id;
    mediaKey = state.mediaKey;

    await Api.call(
      context,
      () => ProjectsApi.getProjectFile(state.projectKey, state.mediaCollection.id, state.mediaKey),
      onSuccess: (Response response) {
        mediaResponse = response;
      },
    );
    return mediaResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationScreenState>(
      builder: (context, state, _) {
        return FutureBuilder<Response?>(
          future: getMediaResponse(context, state),
          builder: (BuildContext context, AsyncSnapshot<Response?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              switch (state.mediaCollection.mediaType) {
                case ProjectMediaType.IMAGES:
                  return Image.memory(
                    snapshot.data!.data,
                    scale: 0.000000000001,
                  );
                // case ProjectMediaType.VIDEO:
                //child = AspectRatio(aspectRatio: aspectRatio, child: video);
                //   break;
                default:
                  return AspectRatio(
                      aspectRatio: KlintThemeData.defaultAspectRatioWidth / KlintThemeData.defaultAspectRatioHeight,
                      child: Container(
                        width: KlintThemeData.defaultAspectRatioWidth,
                        height: KlintThemeData.defaultAspectRatioHeight,
                      ));
              }
            } else {
              return CircularProgressIndicator(color: Colors.white);
            }
          },
        );
      },
    );
  }
}
