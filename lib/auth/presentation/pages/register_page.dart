import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Crear Cuenta'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction_rounded,
                size: 64,
                color: AppColors.primaryContainer,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Registro en desarrollo',
                style: AppTypography.titleMD,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Usa las credenciales demo para probar la app',
                style: AppTypography.bodyMD
                    .copyWith(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credenciales Demo:',
                      style: AppTypography.labelSM
                          .copyWith(color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Admin: admin@urbania.demo',
                      style: AppTypography.bodyMD,
                    ),
                    Text(
                      'Pass: Urbania2026!',
                      style: AppTypography.bodyMD,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Residente: residente@urbania.demo',
                      style: AppTypography.bodyMD,
                    ),
                    Text(
                      'Pass: Residente2026!',
                      style: AppTypography.bodyMD,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}