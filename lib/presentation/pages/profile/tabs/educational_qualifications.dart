import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/controllers/edu_controllers.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../components/components.dart';

// ignore: must_be_immutable
class EducationalQualifications extends StatefulWidget {
  EducationalQualifications({
    Key? key,
    this.eduControllers = const [],
  }) : super(key: key);
  List<EduControllers> eduControllers;

  @override
  State<EducationalQualifications> createState() =>
      _EducationalQualificationsState();
}

class _EducationalQualificationsState extends State<EducationalQualifications> {
  late bool isLoading;
  late List<String> certificateNames;
  late List<String> degrees;
  late List<DateTime?> dates;
  late bool enabled;

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
  }

  @override
  Widget build(BuildContext context) {
    enabled = Provider.of<UpdateActionBarActions>(context).edit;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        height: MediaQuery.of(context).size.height,
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
                text: 'Add a Certificate',
                press: () {
                  setState(() {
                    widget.eduControllers.insert(
                      widget.eduControllers.length,
                      EduControllers(),
                    );
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
            if (widget.eduControllers.isNotEmpty) ...[
              ListView.separated(
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 30)),
                itemBuilder: (context, index) => EduQualificationItem(
                  eduControllers: widget.eduControllers[index],
                  enabled: enabled,
                  index: index,
                  delete: (idx) {
                    setState(() {
                      widget.eduControllers.removeAt(idx);
                    });
                  },
                ),
                itemCount: widget.eduControllers.length,
                shrinkWrap: true,
                primary: false,
              ),
              const SizedBox(height: 120),
            ],
            if (widget.eduControllers.isEmpty) ...[
              const SizedBox(height: 100),
              Image.asset('assets/png/Asset 2.png', height: 200),
              const SizedBox(height: 50),
              const Center(
                child: ListTile(
                  title: Text(
                    'No Educational Certificate',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'please add some Certificate to show them',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
