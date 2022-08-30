import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedDropdownButton extends StatelessWidget {
  RoundedDropdownButton({
    Key? key,
    required this.color,
    required this.valueChanged,
    required this.value,
    this.icon = Icons.person,
    this.secColor = Colors.white,
    this.hintText = 'input here',
    this.label = '',
    this.enabled = true,
    this.list = const [],
    this.w = 0.7,
    this.h = 0.06,
  }) : super(key: key);
  final List<String> list;
  List<DropdownMenuItem<String>> newList = [];
  final IconData icon;
  final Color secColor, color;
  final String hintText;
  final double w, h;
  final String label;
  final bool enabled;
  final Function valueChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    newList = list
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: size.width * w,
      height: size.height * h,
      child: Material(
        elevation: 20.0,
        color: color,
        shadowColor: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: DropdownButtonFormField<String>(
          value: newList[0].value,
          dropdownColor: Colors.white,
          items: newList,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          onChanged: (enabled)?(String? val) {
            valueChanged(val);
          }:null,
          autofocus: false,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
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
            enabled: enabled,
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
            icon: Icon(icon, color: secColor),
            hintText: hintText,
            fillColor: secColor,
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
