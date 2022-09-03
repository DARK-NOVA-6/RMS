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

  static List<EvEduQualificationDescription>? fromSnapshot({
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      return documentSnapshot!
          .map((e) => _fromSnapshot(documentSnapshot: e))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  static EvEduQualificationDescription _fromSnapshot({
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvEduQualificationDescription(
      degree: documentSnapshot['degree'],
      field: documentSnapshot['field'],
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
    );
  }

  static List<Map<String, dynamic>> toSnapshot(
    List<EvEduQualificationDescription> evEduQualificationDescriptions,
  ) {
    return evEduQualificationDescriptions.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    EvEduQualificationDescription evEduQualificationDescription,
  ) {
    return {
      'degree': evEduQualificationDescription.degree,
      'field': evEduQualificationDescription.field,
      'is-satisfied': evEduQualificationDescription.isSatisfied,
      'is-required': evEduQualificationDescription.isRequired,
    };
  }
}
