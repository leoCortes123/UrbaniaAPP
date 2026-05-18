import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/auth/presentation/providers/auth_controller.dart';
import 'package:urbania/auth/presentation/states/auth_state.dart';
import 'package:urbania/shared/widgets/app_button.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    String name = 'Usuario';
    String email = '';
    String unit = '';
    String role = '';

    final currentAuthState = authState.valueOrNull;
    if (currentAuthState is Authenticated) {
      name = currentAuthState.name;
      email = currentAuthState.email;
      unit = currentAuthState.unit;
      role = currentAuthState.role;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primaryContainer,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: AppTypography.headlineXL.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(name, style: AppTypography.titleMD),
            Text(
              unit,
              style: AppTypography.bodyMD
                  .copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            _ProfileInfoTile(
              icon: Icons.email_outlined,
              label: 'Correo',
              value: email,
            ),
            _ProfileInfoTile(
              icon: Icons.badge_outlined,
              label: 'Rol',
              value: role == 'admin' ? 'Administrador' : 'Residente',
            ),
            _ProfileInfoTile(
              icon: Icons.home_outlined,
              label: 'Unidad',
              value: unit,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: 'Cerrar Sesión',
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout();
              },
              variant: AppButtonVariant.outline,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.onSurfaceVariant),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSM
                    .copyWith(color: AppColors.onSurfaceVariant),
              ),
              Text(value, style: AppTypography.bodyMD),
            ],
          ),
        ],
      ),
    );
  }
}