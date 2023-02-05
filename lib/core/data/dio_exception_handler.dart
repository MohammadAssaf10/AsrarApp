import 'package:dio/dio.dart';

import 'exception_handler.dart';
import 'failure.dart';

Failure getDioFailure(DioError exception) {
  switch (exception.type) {
    case DioErrorType.connectTimeout:
      return Failure(
          ResponseCode.connectTimeout, ResponseMessage.connectTimeout);

    case DioErrorType.sendTimeout:
      return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);

    case DioErrorType.receiveTimeout:
      return Failure(
          ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);

    case DioErrorType.response:
      return Failure(
          exception.response?.statusCode ?? ResponseCode.defaultError,
          exception.response?.statusMessage ?? ResponseMessage.defaultError);

    case DioErrorType.cancel:
      return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      
    case DioErrorType.other:
      print(exception.error);
      return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
  }
}
