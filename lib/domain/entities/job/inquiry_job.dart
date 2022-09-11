import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class InquiryJob extends Equatable {
  final String inquiry;
  final String name;
  final Timestamp inquiryDate;
  final String? answer;
  final Timestamp? answerDate;

  const InquiryJob({
    required this.inquiry,
    required this.name,
    required this.inquiryDate,
    this.answer,
    this.answerDate,
  });

  @override
  List<Object?> get props => [
        inquiry,
        name,
        inquiryDate,
        answer,
        answerDate,
      ];
}
