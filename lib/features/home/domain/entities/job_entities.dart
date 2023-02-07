import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class JobEntities extends Equatable {
  final int jobId;
  final Timestamp timestamp;
  final String jobTitle;
  final String jobDetails;
  final String jobImageName;
  final String jobImageUrl;
  const JobEntities({
    required this.jobId,
    required this.timestamp,
    required this.jobTitle,
    required this.jobDetails,
    required this.jobImageName,
    required this.jobImageUrl,
  });

  @override
  List<Object> get props {
    return [
      jobId,
      timestamp,
      jobTitle,
      jobDetails,
      jobImageName,
      jobImageUrl,
    ];
  }

  factory JobEntities.fromMap(Map<String, dynamic> map) {
    return JobEntities(
      jobId: map['jobId'],
      timestamp: map['timestamp'],
      jobTitle: map['jobTitle'],
      jobDetails: map['jobDetails'],
      jobImageName: map['jobImageName'],
      jobImageUrl: map['jobImageUrl'],
    );
  }

  @override
  String toString() {
    return 'JobEntities(jobId: $jobId, timestamp: $timestamp, jobTitle: $jobTitle, jobDetails: $jobDetails, jobImageName: $jobImageName, jobImageUrl: $jobImageUrl)';
  }
}
