import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CourseEntities extends Equatable {
  final String courseTitile;
  final String courseContent;
  final String coursePrice;
  final String courseImageName;
  final String courseImageUrl;
  final Timestamp timestamp;
  const CourseEntities({
    required this.courseTitile,
    required this.courseContent,
    required this.coursePrice,
    required this.courseImageName,
    required this.courseImageUrl,
    required this.timestamp,
  });
  @override
  List<Object> get props {
    return [
      courseTitile,
      courseContent,
      coursePrice,
      courseImageName,
      courseImageUrl,
      timestamp,
    ];
  }

  factory CourseEntities.fromMap(Map<String, dynamic> map) {
    return CourseEntities(
      courseTitile: map['courseTitile'],
      courseContent: map['courseContent'],
      coursePrice: map['coursePrice'],
      courseImageName: map['newsImageName'],
      courseImageUrl: map['newsImageUrl'],
      timestamp: map['timestamp'],
    );
  }
  @override
  String toString() {
    return 'CourseEntities(courseTitile: $courseTitile, courseContent: $courseContent, coursePrice: $coursePrice, newsImageName: $courseImageName, newsImageUrl: $courseImageUrl, timestamp: $timestamp)';
  }
}
