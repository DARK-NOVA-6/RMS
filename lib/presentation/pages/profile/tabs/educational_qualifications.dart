import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:untitled/provider/theme.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../components/my_elevated_button.dart';
import '../../../components/rounded_text_field.dart';

class EducationalQualifications extends StatefulWidget {
  const EducationalQualifications({
    Key? key,
  }) : super(key: key);

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
    certificateNames = [
      'certificateNames1',
      'certificateNames2',
      'certificateNames3',
      'certificateNames4',
      'certificateNames5',
      'certificateNames6',
    ];
    degrees = [
      'degrees1',
      'degrees2',
      'degrees3',
      'degrees4',
      'degrees5',
      'degrees6',
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
                MyElevatedButton(text: 'Add a Certificate', press: () {}),
                const SizedBox(height: 20),
              ],
              ListView.separated(
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 30)),
                itemBuilder: (context, index) => EduQualificationItem(
                  enabled: enabled,
                  certificateNames: certificateNames,
                  degrees: degrees,
                  index: index,
                ),
                itemCount: 5,
                shrinkWrap: true,
                primary: false,
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

class EduQualificationItem extends StatefulWidget {
  const EduQualificationItem({
    Key? key,
    required this.enabled,
    required this.certificateNames,
    required this.degrees,
    required this.index,
  }) : super(key: key);

  final bool enabled;
  final List<String> certificateNames;
  final List<String> degrees;
  final int index;

  @override
  State<EduQualificationItem> createState() => _EduQualificationItemState();
}

class _EduQualificationItemState extends State<EduQualificationItem> {
  DateTime gDate = DateTime.now();
  TextEditingController gDateText = TextEditingController();
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
                  onPressed: () {},
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
              RoundedTextField(
                color: Theme.of(context).primaryColor,
                controller: TextEditingController(),
                label: 'University',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              CustomeAutoComplete(
                list: widget.certificateNames,
                label: 'Certificate Name',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              CustomeAutoComplete(
                list: widget.degrees,
                label: 'Degree',
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
                      controller: gDateText,
                      color: Theme.of(context).primaryColor,
                      label: 'Graduation',
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
                              gDateText.text = DateFormat.yMMMd().format(value);
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomeAutoComplete extends StatefulWidget {
  const CustomeAutoComplete({
    Key? key,
    required this.list,
    required this.enabled,
    this.label = '',
    this.w = .7,
  }) : super(key: key);

  final List<String> list;
  final bool enabled;
  final String label;
  final double w;

  @override
  State<CustomeAutoComplete> createState() => _CustomeAutoCompleteState();
}

class _CustomeAutoCompleteState extends State<CustomeAutoComplete> {
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsMaxHeight: 100,
      optionsViewBuilder:
          (context, Function(String) onSelected, Iterable<String> options) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, index) {
            String option = options.elementAt(index);
            return Material(
              child: ListTile(
                tileColor: Colors.white,
                title: SubstringHighlight(
                  text: option,
                  term: controller.text,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textStyleHighlight: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  onSelected(option);
                },
              ),
            );
          },
          itemCount: options.length,
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return widget.list;
        }
      },
      onSelected: (selectedString) {},
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        controller = textEditingController;
        return RoundedTextFieldWithAutoComplete(
          w: widget.w,
          label: widget.label,
          widget: widget,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          textEditingController: textEditingController,
        );
      },
    );
  }
}

class RoundedTextFieldWithAutoComplete extends StatelessWidget {
  const RoundedTextFieldWithAutoComplete({
    Key? key,
    required this.widget,
    required this.textEditingController,
    required this.focusNode,
    required this.onFieldSubmitted,
    this.label = '',
    this.w = .7,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function() onFieldSubmitted;
  final CustomeAutoComplete widget;
  final String label;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width * w,
      height: MediaQuery.of(context).size.height * .06,
      child: Material(
        elevation: 20.0,
        color: Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextField(
          style: const TextStyle(
            color: Colors.black,
          ),
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3.0,
              ),
            ),
            enabled: widget.enabled,
            label: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(label),
            ),
            floatingLabelStyle: const TextStyle(
              fontSize: 22,
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
