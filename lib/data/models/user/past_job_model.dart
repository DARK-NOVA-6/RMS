import '../../../domain/entities/user/user_info.dart';

class PastJobModel extends PastJob {
  const PastJobModel({
    required super.title,
    required super.start,
    required super.end,
  });

  static PastJob? fromSnapshot(Map<String, dynamic>? documentSnapshot) {
    try {
      return PastJob(
        title: documentSnapshot!['title'],
        start: documentSnapshot['start'],
        end: documentSnapshot['end'],
      );
    } catch (e) {
      return null;
    }
  }

  static List<PastJob> listFromSnapshot(
      List<Map<String, dynamic>>? documentSnapshot) {
    if (documentSnapshot == null) return [];
    List<PastJob> result = [];
    for (var element in documentSnapshot) {
      var newElement = fromSnapshot(element);
      if (newElement != null) result.add(newElement);
    }
    return result;
  }

  static List<Map<String, dynamic>> listToSnapshot(List<PastJob> experiences) {
    return experiences.map((e) => toSnapshot(e)).toList();
  }

  static Map<String, dynamic> toSnapshot(PastJob experiences) {
    return {
      'title': experiences.title,
      'start': experiences.start,
      'end': experiences.end,
    };
  }
}
