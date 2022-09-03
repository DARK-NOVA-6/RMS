
import 'package:flutter/material.dart';

import 'custome_auto_complete.dart';

class RoundedTextFieldWithAutoComplete extends StatefulWidget {
  const RoundedTextFieldWithAutoComplete({
    Key? key,
    required this.widget,
    required this.textEditingController,
    required this.focusNode,
    required this.onFieldSubmitted,
    this.label = '',
    this.w = .7,
    required this.fetchData,
    required this.callFather,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function fetchData, callFather;
  final FocusNode focusNode;
  final Function() onFieldSubmitted;
  final CustomeAutoComplete widget;
  final String label;
  final double w;

  @override
  State<RoundedTextFieldWithAutoComplete> createState() =>
      _RoundedTextFieldWithAutoCompleteState();
}

class _RoundedTextFieldWithAutoCompleteState
    extends State<RoundedTextFieldWithAutoComplete> {
  // ignore: prefer_typing_uninitialized_variables
  var subscription;

  waitBeforeSending() {
    widget.callFather();
    if (subscription != null) subscription.cancel();
    var future = Future.delayed(const Duration(milliseconds: 500));

    subscription = future.asStream().listen((any) {
      widget.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width * widget.w,
      height: MediaQuery.of(context).size.height * .06,
      child: Material(
        elevation: 20.0,
        color: Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextField(
          onChanged: (val) {
            waitBeforeSending();
          },
          style: const TextStyle(
            color: Colors.black,
          ),
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          onEditingComplete: widget.onFieldSubmitted,
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
            enabled: widget.widget.enabled,
            label: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(widget.label),
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
