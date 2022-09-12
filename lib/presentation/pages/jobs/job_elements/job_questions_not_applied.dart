import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';
import 'package:untitled/domain/usecases/job/recommended/add_inquiry_recommended.dart';
import 'package:untitled/domain/usecases/job/unavailable/add_inquiry_unavailable.dart';

import '../../../components/components.dart';

class JobQuestionsNotApplied extends StatefulWidget {
  const JobQuestionsNotApplied({
    Key? key,
    required this.ejob,
    this.addInquiryRecommended,
    this.addInquiryUnavailable,
  }) : super(key: key);
  final EvaluatedJob ejob;
  final AddInquiryRecommended? addInquiryRecommended;
  final AddInquiryUnavailable? addInquiryUnavailable;

  @override
  State<JobQuestionsNotApplied> createState() => _JobQuestionsNotAppliedState();
}

class _JobQuestionsNotAppliedState extends State<JobQuestionsNotApplied> {
  late EvaluatedJob ejob;
  AddInquiryRecommended? addInquiryRecommended;
  AddInquiryUnavailable? addInquiryUnavailable;

  @override
  void initState() {
    super.initState();
    if (widget.addInquiryRecommended != null) {
      addInquiryRecommended = widget.addInquiryRecommended!;
    }
    if (widget.addInquiryUnavailable != null) {
      addInquiryUnavailable = widget.addInquiryUnavailable!;
    }
    ejob = widget.ejob;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inquiries',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor.withAlpha(100),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: ejob.inquiries.length,
            separatorBuilder: (context, index) => Column(
              children: [
                const SizedBox(height: 10),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 30,
                  endIndent: 40,
                  thickness: 2,
                ),
                const SizedBox(height: 10),
              ],
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                              ejob.inquiries[index].inquiryDate.toDate()),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ejob.inquiries[index].inquiry,
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ejob.inquiries[index].answer != null) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(
                                ejob.inquiries[index].answerDate!.toDate()),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ejob.inquiries[index].answer!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RoundedTextField(
              controller: TextEditingController(),
              color: Theme.of(context).primaryColor,
              enabled: true,
              icon: Icons.question_answer_outlined,
              label: 'Inquiry',
              suffixText: 'Ask',
              suffixPress: (val) {
                if (addInquiryUnavailable != null) {
                  addInquiryUnavailable!(
                    inquiry: val,
                    jobId: ejob.id,
                  ).then((value) {});
                }
                if (addInquiryRecommended != null) {
                  addInquiryRecommended!(
                    inquiry: val,
                    jobId: ejob.id,
                  ).then((value) {});
                }
              },
              multiLines: true,
            ),
          ),
        ],
      ),
    );
  }
}
