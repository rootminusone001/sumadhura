import 'package:flutter/material.dart';

class GenericDropdownWidget extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?) validator;
  final String? Function(String?) onChanged;
  const GenericDropdownWidget({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.labelText,
    required this.items,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      hint: Text(hintText ?? ''),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
