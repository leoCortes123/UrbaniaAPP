import 'package:flutter/material.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';

class IngresosPage extends StatelessWidget {
  const IngresosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Ingresos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.login_rounded,
                size: 64,
                color: AppColors.primaryContainer,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Control de Ingresos',
                style: AppTypography.titleMD,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Gestión de visitas y entradas al conjunto',
                style: AppTypography.bodyMD
                    .copyWith(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}