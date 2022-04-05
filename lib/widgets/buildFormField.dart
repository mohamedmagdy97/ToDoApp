import 'package:flutter/material.dart';

class BuildFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Function()? onTap;
  final TextInputType type;
  final Widget pIcon;
  final String label;

  BuildFormField({
    Key? key,
    required this.controller,
    required this.validator,
    this.onTap,
    required this.type,
    required this.pIcon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
          prefixIcon: pIcon,
          labelText: label,
          border: const OutlineInputBorder()),
    );
  }
}
