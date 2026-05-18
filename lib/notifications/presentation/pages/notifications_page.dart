import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: const [
          _NotificationTile(
            icon: Icons.event_available,
            iconColor: AppColors.primaryContainer,
            title: 'Reserva confirmada',
            subtitle: 'Tu reserva del salón social ha sido confirmada',
            time: 'Hace 2 horas',
          ),
          SizedBox(height: AppSpacing.md),
          _NotificationTile(
            icon: Icons.payment,
            iconColor: AppColors.warning,
            title: 'Pago pendiente',
            subtitle: 'Tienes un pago de administración pendiente',
            time: 'Ayer',
          ),
          SizedBox(height: AppSpacing.md),
          _NotificationTile(
            icon: Icons.support_agent,
            iconColor: AppColors.error,
            title: 'Respuesta a tu PQRS',
            subtitle: 'La administración ha respondido tu petición',
            time: 'Hace 2 días',
          ),
          SizedBox(height: AppSpacing.md),
          _NotificationTile(
            icon: Icons.info_outline,
            iconColor: AppColors.info,
            title: 'Mantenimiento programado',
            subtitle: 'Se realizará mantenimiento del ascensor el domingo',
            time: 'Hace 3 días',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const _NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMD),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.bodyMD
                      .copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTypography.labelSM
                      .copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}