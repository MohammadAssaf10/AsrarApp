import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../api_constant.dart';

class TapPaymentService {
  static const String _apiBaseUrl = "https://api.tap.company/v2";
  static const String _apiKey = kTestMode ? kTapTestApiKey : kTapAndroidProdKey;
  Dio dio;

  TapPaymentService()
      : dio = Dio(BaseOptions(
          baseUrl: _apiBaseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
        ))
          ..interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
          ));

  Future<String?> refound(
      {required String chargeId,
      required int amount,
      required String currency,
      required String reason}) async {
    Map<String, dynamic> data = {
      'charge_id': chargeId,
      'amount': amount,
      'currency': currency,
      'reason': reason
    };

    var response = await dio.post('/refunds', data: data);

    if (response.statusCode! < 200) {
      return null;
    }

    return response.statusMessage;
  }
}
