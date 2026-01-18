import 'package:flutter/material.dart';

class PillFormInput extends StatelessWidget {
  final bool obscure;
  final String hint;
  final TextInputType type;
  final String label;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  const PillFormInput({
    super.key,
    required this.hint,
    this.obscure = false,
    this.type = TextInputType.text,
    this.label = '',
    this.validator,
    this.value,
    this.onChange,
  });


  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.2),
    );

    return TextFormField(
      obscureText: obscure,
      keyboardType: type,
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        errorMaxLines: 2,
        label: Text(label),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12
        )
      ),
    );
  }}