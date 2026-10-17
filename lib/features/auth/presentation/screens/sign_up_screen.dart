import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/widgets/custom_text_form_field.dart';
import 'package:shopping_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/features/auth/presentation/controllers/signup_form_controller.dart';
import 'package:shopping_app/features/auth/presentation/view_model/register/register_cubit.dart';
import 'package:shopping_app/features/auth/presentation/widgets/login_field_label.dart';
import 'package:shopping_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:shopping_app/features/auth/presentation/widgets/signup_header.dart';
import 'package:shopping_app/features/auth/presentation/widgets/terms_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = SignupFormController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  String? _validateEmail(String? value) {
    final requiredError = _validateRequired(value, 'Please enter your email');
    if (requiredError != null) return requiredError;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final requiredError = _validateRequired(value, 'Please enter a password');
    if (requiredError != null) return requiredError;
    if (value!.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _onSignUp(BuildContext context) {
    if (!_controller.agreeToTerms) {
      _showMessage(
        context,
        'Please agree to Terms & Privacy Policy',
        Colors.orange,
      );
      return;
    }

    if (!_controller.formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().intent(
          Register(
            RegisterRequestEntity(
              name: _controller.nameController.text.trim(),
              phone: _controller.phoneController.text.trim(),
              email: _controller.emailController.text.trim(),
              password: _controller.passwordController.text,
              confirmPassword: _controller.confirmPasswordController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            _showMessage(context, state.message, Colors.green);
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else if (state is RegisterError) {
            _showMessage(context, state.error, Colors.redAccent);
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const SignupHeader(),
                      const SizedBox(height: 32),
                      const LoginFieldLabel(label: 'Full Name'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.nameController,
                        hintText: 'Enter your full name',
                        prefixIcon: const Icon(Icons.person_outline),
                        keyboardType: TextInputType.name,
                        validator: (value) =>
                            _validateRequired(value, 'Please enter your name'),
                      ),
                      const SizedBox(height: 16),
                      const LoginFieldLabel(label: 'Phone Number'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.phoneController,
                        hintText: 'Enter your phone number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        keyboardType: TextInputType.phone,
                        validator: (value) => _validateRequired(
                          value,
                          'Please enter your phone number',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const LoginFieldLabel(label: 'Email'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.emailController,
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      const LoginFieldLabel(label: 'Password'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.passwordController,
                        hintText: 'Create a password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        isPassword: true,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 16),
                      const LoginFieldLabel(label: 'Confirm Password'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.confirmPasswordController,
                        hintText: 'Confirm your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        isPassword: true,
                        validator: (value) {
                          final requiredError = _validateRequired(
                            value,
                            'Please confirm your password',
                          );
                          if (requiredError != null) return requiredError;
                          if (value != _controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TermsCheckbox(
                        value: _controller.agreeToTerms,
                        onChanged: (value) {
                          setState(() => _controller.agreeToTerms = value);
                        },
                      ),
                      const SizedBox(height: 28),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            )
                          : PrimaryButton(
                              text: 'Sign Up',
                              onPressed: () => _onSignUp(context),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
