part of 'evaluated_description.dart';

class EvEduQualificationDescription extends EvaluatedDescription {
  final String degree;
  final String field;

  const EvEduQualificationDescription({
    required this.degree,
    required this.field,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        degree,
        field,
        isSatisfied,
        isRequired,
      ];
}
