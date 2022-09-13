import 'package:equatable/equatable.dart';

class AppliedNote extends Equatable {
  final String note;
  final String state;

  const AppliedNote({
    required this.note,
    required this.state,
  });

  @override
  List<Object?> get props => [
        note,
        state,
      ];
}
