import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.trailing,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: effectiveIconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 20, color: effectiveIconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: theme.hintColor,
                    ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: theme.dividerColor),
          ),
      ],
    );
  }
}
