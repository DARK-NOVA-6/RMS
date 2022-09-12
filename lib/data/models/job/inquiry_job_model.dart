import '../../../domain/entities/job/inquiry_job.dart';

class InquiryJobModel extends InquiryJob {
  const InquiryJobModel({
    required super.inquiry,
    required super.name,
    required super.inquiryDate,
  });

  static List<InquiryJob> fromJsonAndSnapshot(
          List<Map<String, dynamic>> documentSnapshot) =>
      documentSnapshot.map((e) => _fromJsonAndSnapshot(e)).toList();

  static List<Map<String, dynamic>> toJsonAndSnapshot(
    List<InquiryJob> inquiries,
  ) =>
      inquiries.map((e) => _toJsonAndSnapshot(e)).toList();

  static InquiryJob _fromJsonAndSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) =>
      InquiryJob(
        inquiry: documentSnapshot!['inquiry'],
        name: documentSnapshot['name'],
        inquiryDate: documentSnapshot['inquiry-date'],
        answer: documentSnapshot['answer'],
        answerDate: documentSnapshot['answer-date'],
      );

  static Map<String, dynamic> _toJsonAndSnapshot(
    InquiryJob inquiry,
  ) =>
      {
        'inquiry': inquiry.inquiry,
        'name': inquiry.name,
        'inquiry-date': inquiry.inquiryDate,
        'answer': inquiry.answer,
        'answer-date': inquiry.answerDate,
      };
}
