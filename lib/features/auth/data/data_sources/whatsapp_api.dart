import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'models/responses.dart';

part 'whatsapp_api.g.dart';

class WhatsAppApiConstance {
  String baseUrl;
  String instance_id;
  String access_token;

  WhatsAppApiConstance._()
      : baseUrl = '',
        access_token = '',
        instance_id = '';

  static final instance = WhatsAppApiConstance._();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'baseUrl': baseUrl});
    result.addAll({'instance_id': instance_id});
    result.addAll({'access_token': access_token});

    return result;
  }

  Future<void> getWhatsAppApiConstants() async {
    final map = (await firestore.FirebaseFirestore.instance
            .collection('API')
            .doc('WHATSAPPAPI')
            .get())
        .data();

    if (map != null) {
      baseUrl = map['baseUrl'] ?? '';
      instance_id = map['instance_id'] ?? '';
      access_token = map['access_token'] ?? '';
    }
  }
}

/// [instance_id], [access_token] and [baseUrl] should fetch from firebase
/// just call [WhatsAppApiConstance.instance]
@RestApi()
abstract class WhatsappApi {
  factory WhatsappApi(Dio dio, {required String baseUrl}) = _WhatsappApi;

  @Header('accept: text/html; charset=UTF-8')
  @POST("/send.php")
  Future<BaseResponse> sendCode(
      {@Query("number") required String number,
      @Query("message") required String message,
      @Query("type") String type = 'text',
      @Query("instance_id") required String instance_id,
      @Query("access_token") required String access_token});
}
