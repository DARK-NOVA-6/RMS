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
}
