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
}
