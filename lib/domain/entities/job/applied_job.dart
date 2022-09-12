import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/domain/entities/job/evaluated_description/evaluated_description.dart';

import 'applied_note.dart';
import 'inquiry_job.dart';

class AppliedJob extends Equatable {
  final String title;
  final String companyName;
  final String appliedId;
  final String jobId;
  final String summary;
  final Timestamp appliedTime;
  final String state;
  final List<EvSkillDescription> skills;
  final List<EvEduQualificationDescription> eduQualifications;
  final List<EvExperienceDescription> experiences;
  final List<EvLanguageDescription> languages;
  final num score;
  final num rate;
  final List<AppliedNote> notes;
  final List<InquiryJob> inquiries;

  const AppliedJob({
    required this.title,
    required this.appliedId,
    required this.jobId,
    required this.companyName,
    required this.appliedTime,
    required this.summary,
    required this.skills,
    required this.eduQualifications,
    required this.experiences,
    required this.languages,
    required this.score,
    required this.state,
    required this.rate,
    required this.notes,
    required this.inquiries,
  });

  @override
  List<Object?> get props =>
      [
        title,
        appliedId,
        jobId,
        companyName,
        appliedTime,
        summary,
        skills,
        eduQualifications,
        experiences,
        languages,
        score,
        state,
        rate,
        notes,
        inquiries,
      ];
}
