import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../../provider/theme.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';
import 'educational_qualifications.dart';

class Skills extends StatefulWidget {
  const Skills({
    Key? key,
  }) : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  late bool isLoading;
  late List<String> titles;
  late bool enabled;
  List<SkillsControllers> skillsControllers = [];

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
      'skill1',
      'skill2',
      'skill3',
      'skill4',
      'skill5',
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
                  text: 'Add a Skill',
                  press: () {
                    setState(() {
                      skillsControllers.insert(
                        skillsControllers.length,
                        SkillsControllers(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
              if (skillsControllers.isNotEmpty) ...[
                ListView.separated(
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 15)),
                  itemBuilder: (context, index) => SkillItem(
                    skillsController: skillsControllers[index],
                    enabled: enabled,
                    titles: titles,
                    index: index,
                    delete: (idx) {
                      setState(() {
                        skillsControllers.removeAt(idx);
                      });
                    },
                  ),
                  itemCount: skillsControllers.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 120),
              ],
              if (skillsControllers.isEmpty) ...[
                const SizedBox(height: 100),
                Image.asset('assets/png/Asset 2.png', height: 200),
                const SizedBox(height: 50),
                const Center(
                  child: ListTile(
                    title: Text(
                      'No Skills',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'please add some Skills to show them',
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

class SkillItem extends StatefulWidget {
  const SkillItem({
    Key? key,
    required this.enabled,
    required this.titles,
    required this.index,
    required this.skillsController,
    required this.delete,
  }) : super(key: key);

  final bool enabled;
  final List<String> titles;
  final int index;
  final SkillsControllers skillsController;
  final Function(int) delete;

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  DateTime gDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomeTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15).copyWith(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomeAutoComplete(
                controller: widget.skillsController.title,
                list: widget.titles,
                label: 'Title',
                enabled: widget.enabled,
                w: widget.enabled ? 0.7 : 0.8,
              ),
            ],
          ),
          if (widget.enabled) ...[
            IconButton(
              padding: const EdgeInsets.only(right: 1, bottom: 2),
              onPressed: () {
                widget.delete(widget.index);
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
