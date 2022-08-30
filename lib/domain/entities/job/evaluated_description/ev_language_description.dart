part of 'evaluated_description.dart';

class EvLanguageDescription extends EvaluatedDescription {
  final String title;

  const EvLanguageDescription({
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
