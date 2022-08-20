import 'package:equatable/equatable.dart';

class PastJob extends Equatable {
  final String title;
  final String company;
  final DateTime start;
  final DateTime end;

  const PastJob({
    required this.title,
    required this.company,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [
        title,
        company,
        start,
        end,
      ];
}
