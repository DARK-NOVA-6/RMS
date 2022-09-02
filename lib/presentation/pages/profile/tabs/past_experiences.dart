import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../../provider/theme.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';
import 'educational_qualifications.dart';

class PastExperiences extends StatefulWidget {
  const PastExperiences({
    Key? key,
  }) : super(key: key);

  @override
  State<PastExperiences> createState() => _PastExperiencesState();
}

class _PastExperiencesState extends State<PastExperiences> {
  late bool isLoading;
  late List<String> titles;
  late List<DateTime?> dates;
  late List<double> durations;
  late bool enabled;
  List<ExpControllers> expControllers = [];

  Future fetchData() async {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    titles = [
      'title1',
      'title2',
      'title3',
      'title5',
      'title4',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    enabled = Provider.of<UpdateActionBarActions>(context).edit;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          child: ListView(
            children: [
              if (enabled) ...[
                MyElevatedButton(
                  text: 'Add an Experience',
                  press: () {
                    setState(() {
                      expControllers.insert(
                        expControllers.length,
                        ExpControllers(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
              if (expControllers.isNotEmpty) ...[
                ListView.separated(
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 30)),
                  itemBuilder: (context, index) => PastExperienceItem(
                    expController: expControllers[index],
                    enabled: enabled,
                    titles: titles,
                    index: index,
                    delete: (idx) {
                      setState(() {
                        expControllers.removeAt(idx);
                      });
                    },
                  ),
                  itemCount: expControllers.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 120),
              ],
              if (expControllers.isEmpty) ...[
                const SizedBox(height: 100),
                Image.asset('assets/png/Asset 2.png', height: 200),
                const SizedBox(height: 50),
                const Center(
                  child: ListTile(
                    title: Text(
                      'No Past Experiences',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'please add some Past Experiences to show them',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PastExperienceItem extends StatefulWidget {
  const PastExperienceItem({
    Key? key,
    required this.enabled,
    required this.titles,
    required this.index,
    required this.expController,
    required this.delete,
  }) : super(key: key);

  final bool enabled;
  final List<String> titles;
  final int index;
  final ExpControllers expController;
  final Function(int) delete;

  @override
  State<PastExperienceItem> createState() => _PastExperienceItemState();
}

class _PastExperienceItemState extends State<PastExperienceItem> {
  DateTime gDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.enabled) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CustomeTheme.c2.withAlpha(70),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.only(right: 1, bottom: 2),
                  onPressed: () {
                    widget.delete(widget.index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: CustomeTheme.c2.withAlpha(70),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ).copyWith(
              topRight: Radius.circular(widget.enabled ? 0 : 10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CustomeAutoComplete(
                controller: widget.expController.title,
                list: widget.titles,
                label: 'Title',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        (widget.enabled ? 0.47 : .8),
                    margin: EdgeInsets.only(right: (widget.enabled ? 10 : 0)),
                    child: RoundedTextField(
                      enabled: false,
                      controller: widget.expController.start,
                      color: Theme.of(context).primaryColor,
                      label: 'Start Date',
                    ),
                  ),
                  if (widget.enabled) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: MyElevatedButton(
                        text: 'Pick A Date',
                        press: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2050),
                        ).then(
                          (value) => setState(() {
                            if (value != null && value != gDate) {
                              gDate = value;
                              widget.expController.start.text =
                                  DateFormat.yMMMd().format(value);
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              RoundedTextField(
                enabled: Provider.of<UpdateActionBarActions>(context).edit,
                controller: widget.expController.duration,
                color: Theme.of(context).primaryColor,
                label: 'Duration (in Years)',
                isDouble: true,
                w: 0.8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
