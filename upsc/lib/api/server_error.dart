import 'package:dio/dio.dart' hide Headers;
import 'package:fluttertoast/fluttertoast.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";

        Fluttertoast.showToast(
            msg: 'Connection timeout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";

        Fluttertoast.showToast(
            msg: 'Receive timeout in send request',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";

        Fluttertoast.showToast(
            msg: 'Receive timeout in connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        break;
      case DioErrorType.response:
        _errorMessage = "Received invalid status code: ${error.response!.data}";
        try {
          if (error.response!.data['msg'] != null) {
            Fluttertoast.showToast(
                msg: '${error.response!.data['msg']}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
            return;
          } else {
            Fluttertoast.showToast(
                msg: error.response!.data['message'].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
            return;
          }
        } catch (error1, stacktrace) {
          if (error.response!.data['msg'] != null) {
            Fluttertoast.showToast(
                msg: '${error.response!.data['msg']}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
            return;
          } else {
            Fluttertoast.showToast(
                msg: 'Exception occurred',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
            print(
                "Exception occurred: $error stackTrace: $stacktrace apiError: ${error.response!.data}");
          }
        }
        break;
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";

        Fluttertoast.showToast(
            msg: 'Request was cancelled',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed. Please check internet connection";

        Fluttertoast.showToast(
            msg: 'Connection failed. Please check internet connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        break;
    }
    return _errorMessage;
  }
}
