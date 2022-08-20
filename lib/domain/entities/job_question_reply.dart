import 'package:equatable/equatable.dart';

import 'job_question_reply_data.dart';

class JobQuestionReply extends Equatable {
  final JobQuestionReplyData question;
  final List<JobQuestionReplyData> replies;

  const JobQuestionReply({
    required this.question,
    required this.replies,
  });

  @override
  List<Object?> get props => [
        question,
        replies,
      ];
}
