import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:klint/logic/config.dart';
import 'package:klint/ui/dialogs/error_dialog.dart';

typedef ApiFunctionWithParameter<T> = Future<Response> Function(T message);
typedef ApiFunctionWithoutParameter = Future<Response> Function();

class Api {
  static final client = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  static Future callWithoutParameter(
    BuildContext context,
    ApiFunctionWithoutParameter apiFunction, {
    Function(Response)? onSuccess,
    Function(Response?)? onServerError,
    Function(Object)? onException,
  }) async {
    return _call<dynamic>(
      context,
      apiFunctionWithoutParameter: apiFunction,
      onSuccess: onSuccess,
      onServerError: onServerError,
      onException: onException,
    );
  }

  static Future callWithParameter<T>(
    BuildContext context,
    ApiFunctionWithParameter<T> apiFunction,
    T message, {
    Function(Response)? onSuccess,
    Function(Response?)? onServerError,
    Function(Object)? onException,
  }) async {
    return _call<T>(
      context,
      apiFunctionWithParameter: apiFunction,
      message: message,
      onSuccess: onSuccess,
      onServerError: onServerError,
      onException: onException,
    );
  }

  static Future _call<T>(
    BuildContext context, {
    ApiFunctionWithoutParameter? apiFunctionWithoutParameter,
    ApiFunctionWithParameter<T>? apiFunctionWithParameter,
    T? message,
    Function(Response)? onSuccess,
    Function(Response?)? onServerError,
    Function(Object)? onException,
  }) async {
    try {
      Response response;

      if (apiFunctionWithParameter != null && message != null) {
        response = await apiFunctionWithParameter(message);
      } else if (apiFunctionWithoutParameter != null) {
        response = await apiFunctionWithoutParameter();
      } else {
        return;
      }

      if (response.statusCode == 200) {
        if (onSuccess != null) onSuccess(response);
      } else {
        onResponseError(context, response, onServerError);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        onResponseError(context, e.response, onServerError);
      } else {
        onExceptionError(context, e, onException);
      }
    } catch (e) {
      onExceptionError(context, e, onException);
    }
  }

  static onResponseError(BuildContext context, Response? response, Function(Response?)? onServerError) {
    var errorMessage = (response == null)
        ? "Unknown response error (Response = null)"
        : "${response.statusCode}: ${response.statusMessage}\n${response.data}";
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
