import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/core/theme/app_shapes.dart';

class PropertyInfo extends StatelessWidget {
  final String propertyName;
  final String address;
  final int totalUnits;

  const PropertyInfo({
    super.key,
    required this.propertyName,
    required this.address,
    required this.totalUnits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppShapes.lg),
        border: Border.all(
          color: AppColors.surfaceContainerHigh,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppSemanticColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppShapes.md),
            ),
            child: const Icon(
              Icons.business,
              color: AppSemanticColors.info,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertyName,
                  style: AppTypography.labelMD.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: AppTypography.labelSM.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                Text(
                  '$totalUnits unidades',
                  style: AppTypography.labelSM.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}