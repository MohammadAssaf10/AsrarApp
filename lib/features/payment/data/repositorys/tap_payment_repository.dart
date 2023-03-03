import 'dart:convert';

import 'package:asrar_app/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TapPaymentService {
  final String _apiBaseUrl = "https://api.tap.company/v2/";
  final String _apiKey = kTapApiKey;
  Dio dio;

  TapPaymentService()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://api.tap.company/v2',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer sk_test_ep2oMYdlZWb9qBRxS3iEJ47F',
          },
        ))
          ..interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
          ));

  // Future<Map<String, dynamic>> makePayment(double amount, String currency, String cardNumber,
  //     String expiryMonth, String expiryYear, String cvv, String name) async {
  //   String apiUrl = "${_apiBaseUrl}charges";
  //   Map<String, String> headers = {
  //     'Authorization': 'Bearer $_apiKey',
  //     'Content-Type': 'application/json'
  //   };
  //   String body = jsonEncode({
  //     'amount': amount.toStringAsFixed(2),
  //     'currency': currency,
  //     'card': {
  //       'number': cardNumber,
  //       'exp_month': expiryMonth,
  //       'exp_year': expiryYear,
  //       'cvc': cvv,
  //       'name': name
  //     }
  //   });

  //   http.Response response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
  //   Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return jsonResponse;
  //   } else {
  //     throw Exception(jsonResponse['message']);
  //   }
  // }

  // Future<Map<String, dynamic>> createCharge({
  //   required double amount,
  //   required String currency,
  //   required String cardNumber,
  //   required int expiryMonth,
  //   required int expiryYear,
  //   required String cvv,
  //   required String name,
  // }) async {
  //   final url = Uri.parse('https://api.tap.company/v2/charges');
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $_apiKey',
  //     },
  //     body: jsonEncode({
  //       'amount': amount,
  //       'currency': currency,
  //       'card': {
  //         'number': cardNumber,
  //         'exp_month': expiryMonth,
  //         'exp_year': expiryYear,
  //         'cvc': cvv,
  //         'name': name,
  //       },
  //       'description': 'Payment for Flutter App',
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     return responseData['response'] as Map<String, dynamic>;
  //   } else {
  //     throw Exception('Failed to create charge.');
  //   }
  // }
  //
  Future<Map<String, dynamic>> createCharge({
    required double amount,
    required String currency,
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    required String name,
  }) async {
    const url = 'https://api.tap.company/v2/charges';

    // final dio = Dio();

    // dio.interceptors.add(PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: true,
    // ));

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'amount': amount,
          'currency': currency,
          'card': {
            'number': cardNumber,
            'exp_month': expiryMonth,
            'exp_year': expiryYear,
            'cvc': cvv,
            'name': name,
          },
          'description': 'Payment for Flutter App',
          'customer': {
            "first_name": "test",
            "middle_name": "test",
            "last_name": "test",
            "email": "test@test.com",
            "phone": {"country_code": "965", "number": "00000000"},
            "description": "test",
            "metadata": {"udf1": "test"},
            "currency": "KWD"
          }
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['response'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create charge.');
      }
    } catch (e) {
      throw Exception('Failed to create charge: $e');
    }
  }

  Future<Map<String, dynamic>> createSource({
    required String name,
    required String number,
    required int expMonth,
    required int expYear,
    required String cvc,
  }) async {
    final dio = Dio();

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    try {
      final response = await dio.post(
        '$_apiBaseUrl/sources',
        data: {
          'type': 'card',
          'name': name,
          'number': number,
          'exp_month': expMonth,
          'exp_year': expYear,
          'cvc': cvc,
        },
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['response'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create source.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to create source. ${e.message}');
    }
  }

  Future<String> createCardToken({
    required String name,
    required String number,
    required int expMonth,
    required int expYear,
    required String cvc,
  }) async {
    try {
      final response = await dio.post(
        '/tokens',
        data: {
          'card': {
            'name': name,
            'number': number,
            'exp_month': expMonth,
            'exp_year': expYear,
            'cvc': cvc,
          }
        },
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['id'] as String;
      } else {
        throw Exception('Failed to create card token.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to create card token. ${e.message}');
    }
  }

  Future<String> makePayment({
    required String name,
    required String number,
    required int expMonth,
    required int expYear,
    required String cvc,
    required String currency,
    required int amount,
    required String description,
    required String email,
    required String phone,
    required String countryCode,
    required String city,
    required String address,
    required String zip,
  }) async {
    try {
      final response = await dio.post(
        '/charges',
        data: {
          'amount': amount,
          'currency': currency,
          'redirect': {
            'url': 'redirectUrl',
          },
          'source': {
            "id": "src_card",
            'type': 'card',
            'name': name,
            'number': number,
            'exp_month': expMonth,
            'exp_year': expYear,
            'cvc': cvc,
          },
          'description': description,
          'receipt': {
            'email': email,
            'sms': phone,
          },
          'customer': {
            'first_name': name,
            'email': email,
            'phone': {
              'country_code': countryCode,
              'number': phone,
            },
          },
          'shipping': {
            'address': {
              'country': countryCode,
              'city': city,
              'address_line1': address,
              'zip': zip,
            },
          },
        },
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['id'] as String;
      } else {
        throw Exception('Failed to make payment.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to make payment. ${e.message}');
    }
  }
}
