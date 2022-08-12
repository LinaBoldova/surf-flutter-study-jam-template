import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final IconData? icon;
  final bool hideText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.label,
    this.icon,
    this.hideText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(50),
        ],
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
        ),
        obscureText: hideText,
      ),
    );
  }
}
