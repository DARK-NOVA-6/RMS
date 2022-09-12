import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    this.pass = false,
    this.email = false,
    this.code = false,
    this.numbers = false,
    this.isDouble = false,
    this.phone = false,
    this.icon = Icons.ac_unit,
    required this.color,
    this.secColor = Colors.white,
    this.hintText = 'input here',
    this.label = '',
    this.enabled = true,
    this.w = 0.7,
    this.h = 0.06,
    this.multiLines = false,
    this.suffixText,
    this.suffixPress,
  }) : super(key: key);
  final TextEditingController controller;
  final bool pass, email, code, numbers, isDouble, phone;
  final IconData icon;
  final Color secColor, color;
  final String hintText;
  final double w, h;
  final String label;
  final bool enabled;
  final bool multiLines;
  final Function(String)? suffixPress;
  final String? suffixText;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: size.width * widget.w,
      height: (widget.multiLines) ? null : size.height * widget.h,
      child: Material(
        elevation: 20.0,
        color: widget.color,
        shadowColor: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          maxLines: (widget.multiLines) ? null : 1,
          keyboardType: (widget.email == true)
              ? TextInputType.emailAddress
              : (widget.code == true ||
                      widget.numbers == true ||
                      widget.isDouble == true)
                  ? TextInputType.number
                  : null,
          inputFormatters: [
            if (widget.phone || widget.code || widget.numbers) ...[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            if (widget.code) ...[
              LengthLimitingTextInputFormatter(6),
            ],
            if (widget.phone) ...[
              LengthLimitingTextInputFormatter(10),
            ],
            if (widget.isDouble) ...[
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ]
          ],
          controller: widget.controller,
          obscureText: widget.pass,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.suffixText != null
                ? TextButton(
                    onPressed: (widget.suffixPress != null)
                        ? () {
                            widget.suffixPress!(widget.controller.text);
                          }
                        : null,
                    child: Text(
                      widget.suffixText!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : null,
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
            icon: (widget.icon == Icons.ac_unit)
                ? null
                : Icon(widget.icon, color: widget.secColor),
            hintText: widget.hintText,
            fillColor: widget.secColor,
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
