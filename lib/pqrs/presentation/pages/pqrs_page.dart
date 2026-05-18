import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';
import 'package:urbania/shared/widgets/status_chip.dart';

class PqrsPage extends StatelessWidget {
  const PqrsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PQRS'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          _PqrCard(
            type: 'Petición',
            subject: 'Ruidos en horario de descanso',
            description: 'Se reportan ruidos fuertes en el apartamento 302 después de las 10pm.',
            status: StatusChipVariant.warning,
            statusLabel: 'En proceso',
            date: '10/05/2026',
          ),
          const SizedBox(height: AppSpacing.md),
          _PqrCard(
            type: 'Queja',
            subject: 'Ascensor fuera de servicio',
            description: 'El ascensor de la torre B lleva 3 días sin funcionar.',
            status: StatusChipVariant.success,
            statusLabel: 'Resuelto',
            date: '05/05/2026',
          ),
          const SizedBox(height: AppSpacing.md),
          _PqrCard(
            type: 'Sugerencia',
            subject: 'Mejora en iluminación',
            description: 'Sugiero instalar más luces en el parque infantil.',
            status: StatusChipVariant.info,
            statusLabel: 'Recibido',
            date: '01/05/2026',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _PqrCard extends StatelessWidget {
  final String type;
  final String subject;
  final String description;
  final StatusChipVariant status;
  final String statusLabel;
  final String date;

  const _PqrCard({
    required this.type,
    required this.subject,
    required this.description,
    required this.status,
    required this.statusLabel,
    required this.date,
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: AppTypography.labelSM
                      .copyWith(color: AppColors.primaryContainer),
                ),
              ),
              const Spacer(),
              StatusChip(label: statusLabel, variant: status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(subject, style: AppTypography.labelMD),
          const SizedBox(height: 4),
          Text(
            description,
            style:
                AppTypography.bodyMD.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Creado: $date',
            style: AppTypography.labelSM.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}