import 'package:equatable/equatable.dart';

class JobQuestionReplyData extends Equatable {
  final String text;

  final String name;

  final String imgUrl;

  final DateTime publishedTime;

  @override
  List<Object?> get props => [
        text,
        name,
        imgUrl,
        publishedTime,
      ];

  const JobQuestionReplyData({
    required this.text,
    required this.name,
    required this.imgUrl,
    required this.publishedTime,
  });
}
