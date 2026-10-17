import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widget/custtom_button.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/widgets/custom_text_form_field.dart';
import 'package:shopping_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:shopping_app/features/auth/presentation/controllers/login_form_controller.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:shopping_app/features/auth/presentation/widgets/login_field_label.dart';
import 'package:shopping_app/features/auth/presentation/widgets/login_header.dart';
import 'package:shopping_app/features/auth/presentation/widgets/login_options_row.dart';
import 'package:shopping_app/features/auth/presentation/widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginFormController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (!_controller.formKey.currentState!.validate()) return;

    context.read<LoginCubit>().intent(
      Login(
        LoginRequestEntity(
          email: _controller.emailController.text.trim(),
          password: _controller.passwordController.text,
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _showMessage(context, state.message, Colors.green);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
          } else if (state is LoginError) {
            _showMessage(context, state.error, Colors.redAccent);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      const LoginHeader(),
                      const SizedBox(height: 40),
                      const LoginFieldLabel(label: 'Email'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.emailController,
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 20),
                      const LoginFieldLabel(label: 'Password'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller.passwordController,
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        isPassword: true,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 12),
                      LoginOptionsRow(
                        rememberMe: _controller.rememberMe,
                        onRememberMeChanged: (value) {
                          setState(() => _controller.rememberMe = value);
                        },
                        onForgotPassword: () {},
                      ),
                      const SizedBox(height: 28),
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        )
                      else
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () => _onLogin(context),
                        ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SocialLoginButtons(),
                      const SizedBox(height: 36),
                      const AuthFooter(),
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
