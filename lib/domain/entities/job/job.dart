import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../job_description.dart';

class Job extends Equatable {
  final String id;
  final String companyName;
  final JobDescription jobDescription;
  final Timestamp publishedTime;

  const Job({
    required this.id,
    required this.companyName,
    required this.jobDescription,
    required this.publishedTime,
  });

  @override
  List<Object?> get props => [
        id,
        companyName,
        jobDescription,
        publishedTime,
      ];
}
