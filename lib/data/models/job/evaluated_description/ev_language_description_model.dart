part of 'evaluated_description_model.dart';

class EvLanguageDescriptionModel extends EvLanguageDescription {
  const EvLanguageDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static EvLanguageDescription? fromJsonAndSnapshot({
    required bool jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return EvLanguageDescription(
        title: documentSnapshot!['title'],
        isSatisfied: jsonData,
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}
