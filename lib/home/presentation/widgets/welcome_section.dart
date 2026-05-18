import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/core/theme/app_colors.dart';

class WelcomeSection extends StatelessWidget {
  final String userName;
  final String propertyName;

  const WelcomeSection({
    super.key,
    required this.userName,
    required this.propertyName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¡Hola, $userName!',
          style: AppTypography.headlineLGMobile.copyWith(
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          propertyName,
          style: AppTypography.bodyMD.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}