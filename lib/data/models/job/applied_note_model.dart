
import '../../../domain/entities/job/applied_note.dart';

class AppliedNoteModel extends AppliedNote {
  const AppliedNoteModel({
    required super.note,
    required super.state,
  });

  static List<AppliedNote>? fromSnapshot(
    List<Map<String, dynamic>>? documentSnapshot,
  ) {
    if (documentSnapshot == null) return [];
    return documentSnapshot.map((e) => _fromSnapshot(e)!).toList();
  }

  static AppliedNote? _fromSnapshot(Map<String, dynamic>? documentSnapshot) {
    if (documentSnapshot == null) return null;
    return AppliedNote(
      note: documentSnapshot['note'],
      state: documentSnapshot['state'],
    );
  }

  static List<Map<String, dynamic>> toSnapshot(
    List<AppliedNote> appliedNote,
  ) =>
      appliedNote.map((e) => _toSnapshot(e)).toList();

  static Map<String, dynamic> _toSnapshot(
    AppliedNote appliedNote,
  ) =>
      {
        'state': appliedNote.state,
        'note': appliedNote.note,
      };
}
