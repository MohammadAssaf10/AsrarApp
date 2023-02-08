import 'dart:convert';

class BaseResponse {
  String? status;
  String? message;
  BaseResponse({
    this.status,
    this.message,
  });

  BaseResponse copyWith({
    String? status,
    String? message,
  }) {
    return BaseResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(status != null){
      result.addAll({'status': status});
    }
    if(message != null){
      result.addAll({'message': message});
    }
  
    return result;
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      status: map['status'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseResponse.fromJson(String source) => BaseResponse.fromMap(json.decode(source));

  @override
  String toString() => 'BaseResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BaseResponse &&
      other.status == status &&
      other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
