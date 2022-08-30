import 'package:equatable/equatable.dart';

part 'ev_skill_description.dart';

part 'ev_edu_qualification_description.dart';

part 'ev_experience_description.dart';

part 'ev_language_description.dart';

abstract class EvaluatedDescription extends Equatable {
  final bool isSatisfied;
  final bool isRequired;

  const EvaluatedDescription({
    required this.isSatisfied,
    required this.isRequired,
  });
}
