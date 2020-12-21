import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscure;
  final IconData icon;
  final String Function(String) validator;
  final String Function(String) onSave;
  final TextInputType keyboardType;
  final double borderRadius;
  final int maxLength;
  final String helperText;

  const CustomTextForm({
    Key key,
    this.label,
    this.controller,
    this.isObscure = false,
    this.icon,
    this.validator,
    this.onSave,
    this.keyboardType,
    this.borderRadius,
    this.maxLength,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        style: theme.textTheme.subtitle2,
        controller: controller,
        obscureText: isObscure,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        onSaved: onSave,
        decoration: InputDecoration(
          counterStyle: TextStyle(fontSize: 0),
          filled: true,
          errorStyle: theme.textTheme.caption.copyWith(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
            borderSide: BorderSide(),
          ),
          prefixIcon: icon == null ? null : Icon(icon),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelText: label,
          helperText: helperText,
        ),
      ),
    );
  }
}
