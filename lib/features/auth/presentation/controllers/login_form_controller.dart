import 'package:flutter/material.dart';

class LoginFormController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
