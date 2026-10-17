import 'package:flutter/material.dart';

class LoginFieldLabel extends StatelessWidget {
  const LoginFieldLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
