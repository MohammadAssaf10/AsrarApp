import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NewsEntities extends Equatable {
  final int newsId;
  final Timestamp timestamp;
  final String newsTitle;
  final String newsContent;
  final String newsImageName;
  final String newsImageUrl;
  const NewsEntities({
    required this.newsId,
    required this.timestamp,
    required this.newsTitle,
    required this.newsContent,
    required this.newsImageName,
    required this.newsImageUrl,
  });

  @override
  List<Object> get props {
    return [
      newsId,
      timestamp,
      newsTitle,
      newsContent,
      newsImageName,
      newsImageUrl,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'newsId': newsId,
      'timestamp': timestamp,
      'newsTitle': newsTitle,
      'newsContent': newsContent,
      'newsImageName': newsImageName,
      'newsImageUrl': newsImageUrl,
    };
  }

  factory NewsEntities.fromMap(Map<String, dynamic> map) {
    return NewsEntities(
      newsId: map['newsId'],
      timestamp: map['timestamp'],
      newsTitle: map['newsTitle'],
      newsContent: map['newsContent'],
      newsImageName: map['newsImageName'],
      newsImageUrl: map['newsImageUrl'],
    );
  }

  @override
  String toString() {
    return 'NewsEntities(newsId: $newsId, timestamp: $timestamp, newsTitle: $newsTitle, newsContent: $newsContent, newsImageName: $newsImageName, newsImageUrl: $newsImageUrl)';
  }
}
