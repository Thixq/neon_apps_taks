// ignore_for_file: public_member_api_docs, document_ignores

import 'package:flutter/material.dart';

/// Custom form field
class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    this.validator,
    this.controller,
    this.hintText,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
  });

  final String? Function(String?)? validator;

  final String? hintText;

  final TextEditingController? controller;

  final bool? obscureText;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.obscureText ?? false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
