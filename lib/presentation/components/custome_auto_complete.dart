
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'rounded_text_field_with_auto_complete.dart';


class CustomeAutoComplete extends StatefulWidget {
  const CustomeAutoComplete({
    Key? key,
    this.autoApi,
    this.degreeController,
    this.autoEduApi,
    required this.enabled,
    this.label = '',
    this.w = .7,
    required this.controller,
  }) : super(key: key);

  final Future<List<String>> Function({
  required String word,
  int? limit,
  bool? exact,
  })? autoApi;

  final Future<List<String>> Function({
  required String word,
  int? limit,
  bool? exact,
  required String degree,
  })? autoEduApi;

  final bool enabled;
  final String label;
  final double w;
  final TextEditingController controller;
  final TextEditingController? degreeController;

  @override
  State<CustomeAutoComplete> createState() => _CustomeAutoCompleteState();
}

class _CustomeAutoCompleteState extends State<CustomeAutoComplete> {
  late TextEditingController tmpController;
  List<String> list = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tmpController = widget.controller;
  }

  fetchList() async {
    List<String> newList = [];
    if (widget.autoApi != null) {
      newList = await widget.autoApi!(word: tmpController.text);
    }
    if (widget.autoEduApi != null) {
      newList = await widget.autoEduApi!(
        word: tmpController.text,
        degree: widget.degreeController!.text,
      );
    }

    setState(() {
      setState(() {
        isLoading = false;
        list = newList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsMaxHeight: 100,
      optionsViewBuilder:
          (context, Function(String) onSelected, Iterable<String> options) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, index) {
            String option = list[index];
            return Material(
              child: ListTile(
                tileColor: Colors.white,
                title: SubstringHighlight(
                  text: option,
                  term: tmpController.text,
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
          itemCount: list.length,
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) => list,
      initialValue: widget.controller.value,
      onSelected: (selectedString) {
        widget.controller.text = tmpController.text;
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        tmpController = textEditingController;
        return RoundedTextFieldWithAutoComplete(
          fetchData: fetchList,
          callFather: () {
            setState(() {
              isLoading = true;
            });
          },
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
