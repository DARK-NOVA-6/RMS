part of 'evaluated_description_model.dart';

class EvExperienceDescriptionModel extends EvExperienceDescription {
  const EvExperienceDescriptionModel({
    required super.title,
    required super.period,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<EvExperienceDescription>? fromJsonAndSnapshot({
    required List<dynamic> jsonData,
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      List<EvExperienceDescription> result = [];
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

  static EvExperienceDescription _fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvExperienceDescription(
      title: documentSnapshot['title'],
      isSatisfied: jsonData,
      isRequired: documentSnapshot['is-required'],
      period: documentSnapshot['period'],
    );
  }

  static List<EvExperienceDescription>? fromSnapshot({
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      return documentSnapshot!
          .map((e) => _fromSnapshot(documentSnapshot: e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static EvExperienceDescription _fromSnapshot({
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvExperienceDescription(
      title: documentSnapshot['title'],
      period: documentSnapshot['period'],
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
    );
  }

  static List<Map<String, dynamic>> toSnapshot(
    List<EvExperienceDescription> evExperienceDescriptions,
  ) {
    return evExperienceDescriptions.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    EvExperienceDescription evExperienceDescription,
  ) {
    return {
      'title': evExperienceDescription.title,
      'period': evExperienceDescription.period,
      'is-satisfied': evExperienceDescription.isSatisfied,
      'is-required': evExperienceDescription.isRequired,
    };
  }
}
