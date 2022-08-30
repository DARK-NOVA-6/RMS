part of 'evaluated_description_model.dart';

class EvEduQualificationDescriptionModel extends EvEduQualificationDescription {
  const EvEduQualificationDescriptionModel({
    required super.degree,
    required super.field,
    required super.isSatisfied,
    required super.isRequired,
  });

  static EvEduQualificationDescription? fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return EvEduQualificationDescription(
        degree: documentSnapshot!['degree'],
        field: documentSnapshot['field'],
        isSatisfied: jsonData,
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}
