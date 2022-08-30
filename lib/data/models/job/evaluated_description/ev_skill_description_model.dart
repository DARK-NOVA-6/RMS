part of 'evaluated_description_model.dart';

class EvSkillDescriptionModel extends EvSkillDescription {
  const EvSkillDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static EvSkillDescription? fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return EvSkillDescription(
        title: documentSnapshot!['title'],
        isSatisfied: jsonData,
        isRequired: documentSnapshot['is-required'],
      );
    } catch(e) {
      return null;
    }
  }
}
