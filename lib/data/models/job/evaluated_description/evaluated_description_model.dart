import '../../../../domain/entities/job/evaluated_description/evaluated_description.dart';

part 'ev_edu_qualification_description_model.dart';
part 'ev_experience_description_model.dart';
part 'ev_language_description_model.dart';
part 'ev_skill_description_model.dart';

abstract class EvaluatedDescriptionModel extends EvaluatedDescription {
  const EvaluatedDescriptionModel({
    required super.isSatisfied,
    required super.isRequired,
  });

  static EvaluatedDescription? fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return EvLanguageDescription(
        title: documentSnapshot!['title'],
        isSatisfied: jsonData,
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}
