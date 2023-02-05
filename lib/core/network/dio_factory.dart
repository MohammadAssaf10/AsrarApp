// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/language.dart';


const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String language = "language";

const int apiTimeOut = 4000;

class DioFactory {
  final LanguageCacheHelper _languagePref;

  DioFactory(this._languagePref);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _languagePref.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      language: language
    };

    dio.options = BaseOptions(
        headers: headers, receiveTimeout: apiTimeOut, sendTimeout: apiTimeOut);

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
