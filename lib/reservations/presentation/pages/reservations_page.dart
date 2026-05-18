import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';
import 'package:urbania/shared/widgets/status_chip.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          _ReservationCard(
            zoneName: 'Salón Social',
            date: '18/05/2026',
            time: '14:00 - 18:00',
            status: StatusChipVariant.success,
            statusLabel: 'Confirmada',
          ),
          const SizedBox(height: AppSpacing.md),
          _ReservationCard(
            zoneName: 'Piscina',
            date: '21/05/2026',
            time: '10:00 - 12:00',
            status: StatusChipVariant.warning,
            statusLabel: 'Pendiente',
          ),
          const SizedBox(height: AppSpacing.md),
          _ReservationCard(
            zoneName: 'Salón de Juegos',
            date: '25/05/2026',
            time: '15:00 - 17:00',
            status: StatusChipVariant.success,
            statusLabel: 'Confirmada',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final String zoneName;
  final String date;
  final String time;
  final StatusChipVariant status;
  final String statusLabel;

  const _ReservationCard({
    required this.zoneName,
    required this.date,
    required this.time,
    required this.status,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(zoneName, style: AppTypography.titleMD),
              StatusChip(label: statusLabel, variant: status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(date, style: AppTypography.bodyMD),
              const SizedBox(width: AppSpacing.md),
              const Icon(Icons.access_time,
                  size: 16, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(time, style: AppTypography.bodyMD),
            ],
          ),
        ],
      ),
    );
  }
}