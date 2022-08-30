part of 'evaluated_description_model.dart';

class EvExperienceDescriptionModel extends EvExperienceDescription {
  const EvExperienceDescriptionModel({
    required super.title,
    required super.period,
    required super.isSatisfied,
    required super.isRequired,
  });

  static EvExperienceDescription? fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return EvExperienceDescription(
        title: documentSnapshot!['title'],
        period: documentSnapshot['period'],
        isSatisfied: jsonData,
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}
