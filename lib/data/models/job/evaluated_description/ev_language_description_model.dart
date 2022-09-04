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

  static List<EvLanguageDescription>? fromSnapshot({
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

  static EvLanguageDescription _fromSnapshot({
    required Map<String, dynamic> documentSnapshot,
  }) {
    return EvLanguageDescription(
      title: documentSnapshot['title'],
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
    );
  }

  static List<Map<String, dynamic>> toSnapshot(
    List<EvLanguageDescription> evLanguageDescriptions,
  ) {
    return evLanguageDescriptions.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    EvLanguageDescription evLanguageDescription,
  ) {
    return {
      'title': evLanguageDescription.title,
      'is-satisfied': evLanguageDescription.isSatisfied,
      'is-required': evLanguageDescription.isRequired,
    };
  }
}
