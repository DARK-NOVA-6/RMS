part of 'evaluated_description.dart';

class EvSkillDescription extends EvaluatedDescription {
  final String title;

  const EvSkillDescription({
    required this.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        isSatisfied,
        isRequired,
      ];
}
