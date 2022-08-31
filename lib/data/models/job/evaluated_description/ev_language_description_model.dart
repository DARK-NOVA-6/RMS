part of 'evaluated_description_model.dart';

class EvLanguageDescriptionModel extends EvLanguageDescription {
  const EvLanguageDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<EvLanguageDescription>? fromJsonAndSnapshot({
    required List<dynamic> jsonData,
    required List<dynamic>? documentSnapshot,
  }) {
    try {
      List<EvLanguageDescription> result = [];
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

  static EvLanguageDescription _fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvLanguageDescription(
      title: documentSnapshot['title'],
      isSatisfied: jsonData,
      isRequired: documentSnapshot['is-required'],
    );
  }
}
