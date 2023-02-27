import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, audio }

/// [type] must be [MessageType.'any'.name]
// * steps to regenerate data class
// - in [toMap] make [createdAt.millisecondsSinceEpoch]
// - in [fromMap] make [fromMillisecondsSinceEpoch]
class MessageDetails {
  Sender sender;
  Timestamp createdAt;
  String type;

  MessageDetails({
    required this.sender,
    required this.createdAt,
    required this.type,
  });

  MessageDetails copyWith({
    Sender? sender,
    Timestamp? createdAt,
    String? type,
  }) {
    return MessageDetails(
      sender: sender ?? this.sender,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sender': sender.toMap()});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'type': type});

    return result;
  }

  factory MessageDetails.fromMap(Map<String, dynamic> map) {
    return MessageDetails(
      sender: Sender.fromMap(map['sender'] ?? {}),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(map['createdAt']),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDetails.fromJson(String source) => MessageDetails.fromMap(json.decode(source));

  @override
  String toString() => 'MessageDetails(sender: $sender, createdAt: $createdAt, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageDetails &&
        other.sender == sender &&
        other.createdAt == createdAt &&
        other.type == type;
  }

  @override
  int get hashCode => sender.hashCode ^ createdAt.hashCode ^ type.hashCode;
}

class Sender {
  String id;
  String name;
  String email;

  Sender({
    required this.id,
    required this.name,
    required this.email,
  });

  Sender copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return Sender(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});

    return result;
  }

  factory Sender.fromMap(Map<String, dynamic> map) {
    return Sender(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sender.fromJson(String source) => Sender.fromMap(json.decode(source));

  @override
  String toString() => 'Sender(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sender && other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}

abstract class Message {
  MessageDetails details;

  Message({required this.details});

  bool isMine(String id) => id == details.sender.id;

  factory Message.fromMap(Map<String, dynamic> map) {
    String? messageType = map['details']['type'];

    if (messageType == MessageType.text.name) {
      return TextMessage.fromMap(map);
    } else if (messageType == MessageType.image.name) {
      return ImageMessage.fromMap(map);
    } else if (messageType == MessageType.audio.name) {
      return VoiceMessage.fromMap(map);
    } else {
      return EmptyMessage.fromMap(map);
    }
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'details': details.toMap()});

    return result;
  }
}

class TextMessage extends Message {
  String content;

  TextMessage({
    required this.content,
    required super.details,
  });

  factory TextMessage.create(String content, Sender sender) {
    return TextMessage(
        content: content,
        details: MessageDetails(
            sender: sender, createdAt: Timestamp.now(), type: MessageType.text.name));
  }

  TextMessage copyWith({
    String? content,
    MessageDetails? details,
  }) {
    return TextMessage(
      content: content ?? this.content,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'content': content});
    result.addAll({'details': details.toMap()});

    return result;
  }

  factory TextMessage.fromMap(Map<String, dynamic> map) {
    return TextMessage(
      content: map['content'] ?? '',
      details: MessageDetails.fromMap(map['details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextMessage.fromJson(String source) => TextMessage.fromMap(json.decode(source));

  @override
  String toString() => 'TextMessage(content: $content, details: $details)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextMessage && other.content == content && other.details == details;
  }

  @override
  int get hashCode => content.hashCode ^ details.hashCode;
}

class ImageMessage extends Message {
  String imageUrl;

  ImageMessage({
    required this.imageUrl,
    required super.details,
  });

  /// imageUrl provided when upload image finish
  factory ImageMessage.create(Sender sender) {
    return ImageMessage(
        imageUrl: 'imageUrl',
        details: MessageDetails(
            sender: sender, createdAt: Timestamp.now(), type: MessageType.image.name));
  }

  ImageMessage copyWith({
    String? imageUrl,
    MessageDetails? details,
  }) {
    return ImageMessage(
      imageUrl: imageUrl ?? this.imageUrl,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'imageUrl': imageUrl});
    result.addAll({'details': details.toMap()});

    return result;
  }

  factory ImageMessage.fromMap(Map<String, dynamic> map) {
    return ImageMessage(
      imageUrl: map['imageUrl'] ?? '',
      details: MessageDetails.fromMap(map['details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageMessage.fromJson(String source) => ImageMessage.fromMap(json.decode(source));

  @override
  String toString() => 'ImageMessage(imageUrl: $imageUrl, details: $details)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageMessage && other.imageUrl == imageUrl && other.details == details;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ details.hashCode;
}

class VoiceMessage extends Message {
  String voiceUrl;

  VoiceMessage({required this.voiceUrl, required super.details});

  VoiceMessage copyWith({String? voiceUrl, MessageDetails? details}) {
    return VoiceMessage(
      voiceUrl: voiceUrl ?? this.voiceUrl,
      details: details ?? this.details,
    );
  }

  /// voiceUrl provided when upload image finish
  factory VoiceMessage.create(Sender sender) {
    return VoiceMessage(
        voiceUrl: 'voiceUrl',
        details: MessageDetails(
            sender: sender, createdAt: Timestamp.now(), type: MessageType.audio.name));
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'voiceUrl': voiceUrl});
    result.addAll({'details': details.toMap()});

    return result;
  }

  factory VoiceMessage.fromMap(Map<String, dynamic> map) {
    return VoiceMessage(
      voiceUrl: map['voiceUrl'] ?? '',
      details: MessageDetails.fromMap(map['details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VoiceMessage.fromJson(String source) => VoiceMessage.fromMap(json.decode(source));

  @override
  String toString() => 'VoiceMessage(voiceUrl: $voiceUrl, details: $details)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoiceMessage && other.voiceUrl == voiceUrl;
  }

  @override
  int get hashCode => voiceUrl.hashCode;
}

class EmptyMessage extends Message {
  EmptyMessage({required super.details});

  factory EmptyMessage.fromMap(Map<String, dynamic> map) {
    return EmptyMessage(
      details: MessageDetails.fromMap(map['details']),
    );
  }
}
