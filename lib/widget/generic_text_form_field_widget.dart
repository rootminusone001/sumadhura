import 'package:flutter/material.dart';

class GenericTextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? Function(String?) validator;
  const GenericTextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
    );
  }
}
