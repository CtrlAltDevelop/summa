import 'package:flutter/material.dart';

import '../tokens/tokens.dart';

/// Single-line text input on glass.
class SmTextField extends StatelessWidget {
  const SmTextField({
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLength,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final int? maxLength;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLength: maxLength,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: SmType.body.copyWith(fontSize: 18),
      cursorColor: SmColors.accent,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        counterText: '',
        labelStyle: SmType.caption,
        hintStyle: SmType.body.copyWith(color: SmColors.textMuted),
        filled: true,
        fillColor: SmColors.glassFill,
        border: const OutlineInputBorder(
          borderRadius: SmRadius.md,
          borderSide: BorderSide(color: SmColors.glassBorder),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: SmRadius.md,
          borderSide: BorderSide(color: SmColors.glassBorder),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: SmRadius.md,
          borderSide: BorderSide(color: SmColors.accent),
        ),
      ),
    );
  }
}
