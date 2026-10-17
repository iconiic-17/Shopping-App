import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hint = '',
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.onToggleVisibility,
    this.validator,
  });

  final String label;
  final String hint;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveHint = hint.isNotEmpty ? hint : (hintText ?? '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: effectiveHint,
            prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : suffixIcon,
          ),
        ),
      ],
    );
  }
}
