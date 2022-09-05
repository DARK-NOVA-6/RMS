import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';
import 'package:untitled/provider/theme.dart';

import '../../pages/jobs/job_details.dart';
import '../my_elevated_button.dart';
import 'costume_expansion_tile.dart';

export 'applied_job.dart';
export 'custome_expansion_tile_applied.dart';

class JobWidget extends StatefulWidget {
  const JobWidget({
    Key? key,
    required this.job,
    required this.callParent,
    required this.isAvailable,
  }) : super(key: key);

  final EvaluatedJob job;
  final Function(EvaluatedJob)? callParent;
  final bool isAvailable;

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: CustomeTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: CustomeTheme.c2,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    widget.job.companyName,
                    style: const TextStyle(
                      fontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMMEd().format(widget.job.publishedTime.toDate()),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyElevatedButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (_) => JobDetails(
                              eJob: widget.job,
                              isAvailable: widget.isAvailable,
                            )))
                    .then((value) {
                  if (value == true) widget.callParent!(widget.job);
                });
              },
              text: widget.job.title,
              w: 1,
              color: Theme.of(context).primaryColor.withAlpha(100),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ReadMoreText(
              widget.job.summary,
              trimMode: TrimMode.Line,
              trimLines: 3,
              style: const TextStyle(fontSize: 16),
              lessStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
              moreStyle: TextStyle(
                color: CustomeTheme.c2.withBlue(200).withGreen(200),
                fontSize: 18,
              ),
              trimExpandedText: ' show less',
            ),
          ),
          CustomExpansionTile(job: widget.job),
        ],
      ),
    );
  }
}
