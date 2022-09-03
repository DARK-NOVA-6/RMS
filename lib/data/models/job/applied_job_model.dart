import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/data/models/job/evaluated_description/evaluated_description_model.dart';
import 'package:untitled/data/models/job/job_application_states_model.dart';
import 'package:untitled/domain/entities/job/applied_job.dart';
import 'package:untitled/domain/entities/job/job_application_states.dart';

import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/user/user_info.dart' as user_ent;

class AppliedJobModel extends AppliedJob {
  const AppliedJobModel({
    required super.title,
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
        title: documentSnapshot!['title'],
        companyName: documentSnapshot['company-name'],
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
    required user_ent.UserInfo userInfo,
  }) {
    return {
      'company-name': evaluatedJob.companyName,
      'title': evaluatedJob.title,
      'job-id': evaluatedJob.id,
      'job-seeker-id': userInfo.id,
      'applied-time': timestamp,
      'summary-job': evaluatedJob.summary,
      'summary-job-seeker': userInfo.summary ?? '',
      'full-name-job-seeker':
          '${userInfo.firstName} ${userInfo.middleName} ${userInfo.lastName}',
      'score': evaluatedJob.score,
      'state':
          ApplicationStatesModel.stateToString(ApplicationStates.screening),
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
