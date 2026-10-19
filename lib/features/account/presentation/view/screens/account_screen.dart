import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/flutter_secure_storage.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/widgets/app_confirm_dialog.dart';
import 'package:shopping_app/core/widgets/safe_network_image.dart';
import 'package:shopping_app/features/account/domain/entities/item_entity.dart';
import 'package:shopping_app/features/account/presentation/view/screens/edit_profile_screen.dart';
import 'package:shopping_app/features/account/presentation/view/widget/account_item.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<AccountCubit>();
      if (cubit.state is AccountInitial || cubit.state.user == null) {
        cubit.getProfile();
      }
    });
  }

  void _navigateToEditProfile(UserProfileEntity? user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(user: user),
      ),
    );
  }

  Future<void> _onLogout() async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Log Out',
      message: 'Are you sure you want to log out of your account?',
      confirmText: 'Log Out',
      cancelText: 'Cancel',
    );

    if (confirmed && mounted) {
      final storage = serviceLocator<AppSecureStorage>();
      await storage.delete(AppKeys.token);
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.login,
          (route) => false,
        );
      }
    }
  }

  Widget _buildProfileHeader(UserProfileEntity? user) {
    final hasValidImage = user != null &&
        user.image.isNotEmpty &&
        SafeNetworkImage.isValidUrl(user.image);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: ClipOval(
                  child: hasValidImage
                      ? SafeNetworkImage(
                          url: user.image,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppColors.primaryLight,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name.isNotEmpty == true
                          ? user!.name
                          : 'User Profile',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: AppFontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email.isNotEmpty == true
                          ? user!.email
                          : 'No email added',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user?.phone.isNotEmpty == true &&
                        user?.phone != 'not added') ...[
                      const SizedBox(height: 4),
                      Text(
                        user!.phone,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: () => _navigateToEditProfile(user),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: AppFontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          final user = state.user;

          if (state is AccountLoading && user == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is AccountError && user == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AccountCubit>().getProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => context.read<AccountCubit>().getProfile(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  _buildProfileHeader(user),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'Account Settings',
                    children: [
                      AccountItem(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                        subtitle: 'Update your profile photo and info',
                        onTap: () => _navigateToEditProfile(user),
                      ),
                      AccountItem(
                        icon: Icons.location_on_outlined,
                        title: 'Shipping Address',
                        subtitle: user?.address.isNotEmpty == true &&
                                user?.address != 'not added'
                            ? user!.address
                            : 'Add delivery address',
                        onTap: () => _navigateToEditProfile(user),
                      ),
                      AccountItem(
                        icon: Icons.lock_outline,
                        title: 'Security & Password',
                        subtitle: 'Manage your password',
                        showDivider: false,
                        onTap: () => _navigateToEditProfile(user),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'Preferences',
                    children: [
                      AccountItem(
                        icon: Icons.notifications_none,
                        title: 'Notifications',
                        subtitle: 'Offers, order updates & alerts',
                        onTap: () {},
                      ),
                      AccountItem(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: 'English (US)',
                        onTap: () {},
                      ),
                      AccountItem(
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        subtitle: 'FAQs and support contact',
                        showDivider: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'Account Actions',
                    children: [
                      AccountItem(
                        icon: Icons.logout,
                        iconColor: AppColors.red,
                        textColor: AppColors.red,
                        title: 'Log Out',
                        subtitle: 'Sign out from this device',
                        showDivider: false,
                        onTap: _onLogout,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
