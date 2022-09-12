import '../../../domain/entities/job/inquiry_job.dart';

class InquiryJobModel extends InquiryJob {
  const InquiryJobModel({
    required super.inquiry,
    required super.name,
    required super.inquiryDate,
  });

  static List<InquiryJob> fromSnapshot(
          List<Map<String, dynamic>> documentSnapshot) =>
      documentSnapshot.map((e) => _fromSnapshot(e)).toList();

  static List<Map<String, dynamic>> toSnapshot(
    List<InquiryJob> inquiries,
  ) =>
      inquiries.map((e) => _toSnapshot(e)).toList();

  static InquiryJob _fromSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) =>
      InquiryJob(
        inquiry: documentSnapshot!['inquiry'],
        name: documentSnapshot['name'],
        inquiryDate: documentSnapshot['inquiry-date'],
        answer: documentSnapshot['answer'],
        answerDate: documentSnapshot['answer-date'],
      );

  static Map<String, dynamic> _toSnapshot(
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
