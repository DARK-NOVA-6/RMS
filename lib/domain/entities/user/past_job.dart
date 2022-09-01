import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PastJob extends Equatable {
  final String title;
  final Timestamp start;
  final Timestamp end;

  const PastJob({
    required this.title,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [
        title,
        start,
        end,
      ];
}
