import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_shapes.dart';

enum StatusChipVariant { success, warning, error, info, neutral }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusChipVariant variant;

  const StatusChip({
    super.key,
    required this.label,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppShapes.full),
      ),
      child: Text(
        label,
        style: AppTypography.labelSM.copyWith(
          color: colors.foreground,
        ),
      ),
    );
  }

  _ChipColors _getColors() {
    switch (variant) {
      case StatusChipVariant.success:
        return _ChipColors(
          background: AppColors.success.withOpacity(0.1),
          foreground: AppColors.success,
        );
      case StatusChipVariant.warning:
        return _ChipColors(
          background: AppColors.warning.withOpacity(0.1),
          foreground: AppColors.warning,
        );
      case StatusChipVariant.error:
        return _ChipColors(
          background: AppColors.error.withOpacity(0.1),
          foreground: AppColors.error,
        );
      case StatusChipVariant.info:
        return _ChipColors(
          background: AppColors.info.withOpacity(0.1),
          foreground: AppColors.info,
        );
      case StatusChipVariant.neutral:
        return _ChipColors(
          background: AppColors.onSurfaceVariant.withOpacity(0.1),
          foreground: AppColors.onSurfaceVariant,
        );
    }
  }
}

class _ChipColors {
  final Color background;
  final Color foreground;

  _ChipColors({required this.background, required this.foreground});
}