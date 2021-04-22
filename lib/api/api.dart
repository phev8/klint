import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:klint/logic/config.dart';
import 'package:klint/ui/dialogs/error_dialog.dart';

class Api {
  static final client = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  static Future call(
    BuildContext context,
    Future<Response> Function() apiFunction, {
    Function(Response)? onSuccess,
    Function(Response?)? onServerError,
    Function(Object)? onException,
  }) async {
    try {
      Response response = await apiFunction();

      if (response.statusCode == 200) {
        if (onSuccess != null) onSuccess(response);
      } else {
        onResponseError(context, response, onServerError);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response && e.response != null) {
        onResponseError(context, e.response!, onServerError);
      } else {
        onExceptionError(context, e, onException);
      }
    } catch (e) {
      onExceptionError(context, e, onException);
    }
  }

  static onResponseError(BuildContext context, Response response, Function(Response?)? onServerError) {
    var errorMessage = "${response.statusCode}: ${response.statusMessage}\n${response.data}";
    print(errorMessage);
    ErrorDialog.display(context, errorMessage);
    if (onServerError != null) onServerError(response);
  }

  static onExceptionError(BuildContext context, Object e, Function(Object)? onException) {
    print(e.toString());
    ErrorDialog.display(context, e.toString());
    if (onException != null) onException(e);
  }
}
