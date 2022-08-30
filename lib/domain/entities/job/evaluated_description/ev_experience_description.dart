part of 'evaluated_description.dart';

class EvExperienceDescription extends EvaluatedDescription {
  final String title;
  final num period;

  const EvExperienceDescription({
    required this.title,
    required this.period,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        period,
        isSatisfied,
        isRequired,
      ];
}
