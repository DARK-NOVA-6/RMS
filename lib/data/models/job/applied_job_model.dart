import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/data/models/job/evaluated_description/evaluated_description_model.dart';
import 'package:untitled/domain/entities/job/applied_job.dart';

import '../../../domain/entities/job/evaluated_job.dart';

class AppliedJobModel extends AppliedJob {
  const AppliedJobModel({
    required super.appliedId,
    required super.companyName,
    required super.appliedTime,
    required super.summary,
    required super.skills,
    required super.eduQualifications,
    required super.experiences,
    required super.languages,
    required super.score,
    required super.state,
  });

  static AppliedJob? fromSnapshot({
    required String id,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return AppliedJob(
        appliedId: id,
        companyName: documentSnapshot!['company-name'],
        appliedTime: documentSnapshot['applied-time'],
        summary: documentSnapshot['summary-job'],
        score: documentSnapshot['score'],
        state: documentSnapshot['state'],
        skills: EvSkillDescriptionModel.fromSnapshot(
          documentSnapshot: documentSnapshot['skills'],
        )!,
        eduQualifications: EvEduQualificationDescriptionModel.fromSnapshot(
          documentSnapshot: documentSnapshot['edu-qualifications'],
        )!,
        experiences: EvExperienceDescriptionModel.fromSnapshot(
          documentSnapshot: documentSnapshot['experiences'],
        )!,
        languages: EvLanguageDescriptionModel.fromSnapshot(
          documentSnapshot: documentSnapshot['languages'],
        )!,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Map<String, dynamic> toSnapshot({
    required EvaluatedJob evaluatedJob,
    required Timestamp timestamp,
    required String? summaryUser,
  }) {
    return {
      'company-name': evaluatedJob.companyName,
      'job-id': evaluatedJob.id,
      'applied-time': timestamp,
      'summary-job': evaluatedJob.summary,
      'summary-job-seeker': summaryUser ?? '',
      'score': evaluatedJob.score,
      'state': 'state 1',
      'edu-qualifications': EvEduQualificationDescriptionModel.toSnapshot(
        evaluatedJob.eduQualifications,
      ),
      'experiences': EvExperienceDescriptionModel.toSnapshot(
        evaluatedJob.experiences,
      ),
      'languages': EvLanguageDescriptionModel.toSnapshot(
        evaluatedJob.languages,
      ),
      'skills': EvSkillDescriptionModel.toSnapshot(
        evaluatedJob.skills,
      ),
    };
  }
}
