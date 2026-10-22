import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/core/common/widget/custom_text_field.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/widgets/app_snackbar.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/account/domain/entities/account_item_entity.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.user});

  final UserProfileEntity? user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  String? _pickedImagePath;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final user = widget.user ?? context.read<AccountCubit>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(
      text:
          user?.phone != null &&
              user!.phone.isNotEmpty &&
              user.phone != 'not added'
          ? user.phone
          : '',
    );
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _pickedImagePath = picked.path;
        });
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          message: 'Failed to pick image: $e',
          isError: true,
        );
      }
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final sheetTheme = Theme.of(ctx);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: sheetTheme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Change Profile Photo',
                  style: sheetTheme.textTheme.bodyLarge?.copyWith(
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sheetTheme.colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: sheetTheme.colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    'Take Photo',
                    style: sheetTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Use camera to take a new picture',
                    style: sheetTheme.textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.camera);
                  },
                ),
                Divider(height: 1, color: sheetTheme.dividerColor),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sheetTheme.colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.photo_library,
                      color: sheetTheme.colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: sheetTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Select an existing photo',
                    style: sheetTheme.textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final params = UpdateProfileParams(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text.isNotEmpty
          ? _passwordController.text
          : null,
      imagePath: _pickedImagePath,
    );

    context.read<AccountCubit>().updateProfile(params);
  }

  Widget _buildAvatar(UserProfileEntity? user) {
    Widget imageContent;

    if (_pickedImagePath != null && _pickedImagePath!.isNotEmpty) {
      imageContent = Image.file(
        File(_pickedImagePath!),
        width: 124,
        height: 124,
        fit: BoxFit.cover,
      );
    } else if (user != null &&
        user.image.isNotEmpty &&
        SafeNetworkImage.isValidUrl(user.image)) {
      imageContent = SafeNetworkImage(
        url: user.image,
        width: 124,
        height: 124,
        fit: BoxFit.cover,
      );
    } else {
      imageContent = Container(
        width: 124,
        height: 124,
        color: AppColors.primaryLight,
        child: const Icon(Icons.person, size: 64, color: AppColors.primary),
      );
    }

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 124,
            height: 124,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(child: imageContent),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _showImagePickerSheet,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountUpdateSuccess) {
          showAppSnackBar(context, message: state.message, isError: false);
          Navigator.of(context).pop();
        } else if (state is AccountUpdateError) {
          showAppSnackBar(context, message: state.message, isError: true);
        }
      },
      builder: (context, state) {
        final currentUser = state.user ?? widget.user;
        final isLoading = state is AccountUpdateLoading;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: AppColors.black,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text(
              'Edit Profile',
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: AppFontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildAvatar(currentUser),
                    const SizedBox(height: 32),
                    CustomTextField(
                      label: 'Name',
                      controller: _nameController,
                      hint: 'Enter your name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Phone',
                      controller: _phoneController,
                      hint: 'Enter your phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      hint: '••••••••',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor: AppColors.greyDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Submit',
                                style: textTheme.labelLarge,
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
