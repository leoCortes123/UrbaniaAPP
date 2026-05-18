import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';
import 'package:urbania/shared/widgets/status_chip.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          _PaymentCard(
            concept: 'Administración Mayo 2026',
            amount: 850000,
            dueDate: '31/05/2026',
            status: StatusChipVariant.warning,
            statusLabel: 'Pendiente',
          ),
          const SizedBox(height: AppSpacing.md),
          _PaymentCard(
            concept: 'Administración Abril 2026',
            amount: 850000,
            dueDate: '30/04/2026',
            status: StatusChipVariant.success,
            statusLabel: 'Pagado',
          ),
          const SizedBox(height: AppSpacing.md),
          _PaymentCard(
            concept: 'Administración Marzo 2026',
            amount: 850000,
            dueDate: '31/03/2026',
            status: StatusChipVariant.success,
            statusLabel: 'Pagado',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String concept;
  final int amount;
  final String dueDate;
  final StatusChipVariant status;
  final String statusLabel;

  const _PaymentCard({
    required this.concept,
    required this.amount,
    required this.dueDate,
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
              Expanded(
                child: Text(
                  concept,
                  style: AppTypography.labelMD,
                ),
              ),
              StatusChip(label: statusLabel, variant: status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor',
                    style: AppTypography.labelSM
                        .copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  Text(
                    '\$${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: AppTypography.titleMD.copyWith(
                      color: status == StatusChipVariant.warning
                          ? AppColors.warning
                          : AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status == StatusChipVariant.warning
                        ? 'Vence'
                        : 'Pagado el',
                    style: AppTypography.labelSM
                        .copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  Text(
                    dueDate,
                    style: AppTypography.bodyMD,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}