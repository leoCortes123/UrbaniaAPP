import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urbania/core/alert/alert_service.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/core/theme/app_shapes.dart';

class AlertBanner extends ConsumerWidget {
  const AlertBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertService = ref.watch(alertServiceProvider);
    final alerts = alertService.alerts;

    if (alerts.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: 0,
      left: AppSpacing.gutter,
      right: AppSpacing.gutter,
      child: Column(
        children: alerts.asMap().entries.map((entry) {
          final index = entry.key;
          final alert = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _AlertBannerItem(
              alert: alert,
              onDismiss: () => alertService.removeAt(index),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AlertBannerItem extends StatelessWidget {
  final Alert alert;
  final VoidCallback onDismiss;

  const _AlertBannerItem({
    required this.alert,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final icon = _getIcon();

    return Material(
      color: colors.background,
      borderRadius: BorderRadius.circular(AppShapes.sm),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, color: colors.foreground, size: 24),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    alert.title,
                    style: TextStyle(
                      color: colors.foreground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (alert.message != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      alert.message!,
                      style: TextStyle(
                        color: colors.foreground.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (alert.dismissible)
              IconButton(
                icon: Icon(Icons.close, color: colors.foreground, size: 20),
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }

  _AlertColors _getColors() {
    switch (alert.type) {
      case AlertType.error:
        return _AlertColors(
          background: AppColors.error.withOpacity(0.1),
          foreground: AppColors.error,
        );
      case AlertType.success:
        return _AlertColors(
          background: AppColors.success.withOpacity(0.1),
          foreground: AppColors.success,
        );
      case AlertType.warning:
        return _AlertColors(
          background: AppColors.warning.withOpacity(0.1),
          foreground: AppColors.warning,
        );
      case AlertType.info:
        return _AlertColors(
          background: AppColors.info.withOpacity(0.1),
          foreground: AppColors.info,
        );
      case AlertType.system:
        return _AlertColors(
          background: AppColors.primary.withOpacity(0.1),
          foreground: AppColors.primary,
        );
    }
  }

  IconData _getIcon() {
    switch (alert.type) {
      case AlertType.error:
        return Icons.error_rounded;
      case AlertType.success:
        return Icons.check_circle_rounded;
      case AlertType.warning:
        return Icons.warning_amber_rounded;
      case AlertType.info:
        return Icons.info_rounded;
      case AlertType.system:
        return Icons.notifications_active_rounded;
    }
  }
}

class _AlertColors {
  final Color background;
  final Color foreground;

  _AlertColors({required this.background, required this.foreground});
}