part of 'evaluated_description_model.dart';

class EvSkillDescriptionModel extends EvSkillDescription {
  const EvSkillDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<EvSkillDescription>? fromJsonAndSnapshot({
    required List<dynamic> jsonData,
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      List<EvSkillDescription> result = [];
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

  static EvSkillDescription _fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvSkillDescription(
      title: documentSnapshot['title'],
      isSatisfied: jsonData,
      isRequired: documentSnapshot['is-required'],
    );
  }

  static List<EvSkillDescription>? fromSnapshot({
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

  static EvSkillDescription _fromSnapshot({
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvSkillDescription(
      title: documentSnapshot['title'],
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
    );
  }

  static List<Map<String, dynamic>> toSnapshot(
    List<EvSkillDescription> evSkillDescriptions,
  ) {
    return evSkillDescriptions.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    EvSkillDescription evSkillDescription,
  ) {
    return {
      'title': evSkillDescription.title,
      'is-satisfied': evSkillDescription.isSatisfied,
      'is-required': evSkillDescription.isRequired,
    };
  }
}
