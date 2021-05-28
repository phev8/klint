import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/state/app_state.dart';
import 'package:provider/provider.dart';

class Frame extends StatelessWidget {
  Future<Response?> getMediaResponse(BuildContext context, AppState state) async {
    Response? futureResponse;
    await Api.call(
      context,
      () => ProjectsApi.getProjectFile(state.projectKey, state.mediaCollection.id, state.mediaKey),
      onSuccess: (Response response) {
        futureResponse = response;
      },
    );
    return futureResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
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
                  return AspectRatio(aspectRatio: 16.0 / 9.0, child: Container(width: 16, height: 9));
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
