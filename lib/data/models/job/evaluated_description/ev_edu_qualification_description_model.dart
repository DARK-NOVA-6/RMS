part of 'evaluated_description_model.dart';

class EvEduQualificationDescriptionModel extends EvEduQualificationDescription {
  const EvEduQualificationDescriptionModel({
    required super.degree,
    required super.field,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<EvEduQualificationDescription>? fromJsonAndSnapshot({
    required List<dynamic> jsonData,
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      List<EvEduQualificationDescription> result = [];
      for (var idx = 0; idx < jsonData.length; idx++) {
        result.add(
          _fromJsonAndSnapshot(
            jsonData: jsonData[idx],
            documentSnapshot: documentSnapshot![idx],
          ),
        );
      }
      return result;
    } catch (e) {
      return null;
    }
  }

  static EvEduQualificationDescription _fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvEduQualificationDescription(
      isSatisfied: jsonData,
      isRequired: documentSnapshot['is-required'],
      degree: documentSnapshot['degree'],
      field: documentSnapshot['field'],
    );
  }
}
