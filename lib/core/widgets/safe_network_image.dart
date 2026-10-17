import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  static String normalize(String value) {
    var s = value.trim();
    if (s.isEmpty) return '';
    final lower = s.toLowerCase();
    if (lower == 'null' || lower == 'undefined' || lower == 'n/a') return '';
    if ((s.startsWith('"') && s.endsWith('"')) ||
        (s.startsWith("'") && s.endsWith("'"))) {
      s = s.substring(1, s.length - 1).trim();
    }
    if (s.startsWith('[') && s.endsWith(']')) {
      try {
        final decoded = jsonDecode(s);
        if (decoded is List && decoded.isNotEmpty) {
          s = decoded.first.toString().trim();
        }
      } catch (_) {}
    }
    final embedded = RegExp(r'https?://[^\s"\]]+').firstMatch(s);
    if (embedded != null) s = embedded.group(0)!;
    if (s.startsWith('//')) s = 'https:$s';
    if (s.startsWith('www.')) s = 'https://$s';
    final uri = Uri.tryParse(s);
    if (uri == null ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return '';
    }
    return uri.toString();
  }

  static bool isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        uri.hasScheme &&
        uri.host.isNotEmpty &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    final clean = normalize(url);
    if (clean.isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: const ColoredBox(
          color: AppColors.fieldFill,
          child: Center(child: Icon(Icons.image_not_supported_outlined)),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: clean,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryOrange,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.image_not_supported_outlined),
      ),
    );
  }
}
