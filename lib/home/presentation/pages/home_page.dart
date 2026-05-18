import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/core/theme/app_shapes.dart';
import 'package:urbania/auth/presentation/providers/auth_controller.dart';
import 'package:urbania/auth/presentation/states/auth_state.dart';
import 'package:urbania/shared/widgets/app_bottom_nav.dart';
import 'package:urbania/home/presentation/providers/home_controller.dart';
import 'package:urbania/home/presentation/widgets/metric_card.dart';
import 'package:urbania/home/presentation/widgets/quick_action_tile.dart';
import 'package:urbania/home/presentation/widgets/welcome_section.dart';
import 'package:urbania/home/presentation/widgets/property_info.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(homeControllerProvider);
    final authState = ref.watch(authControllerProvider);

    String userName = 'Usuario';
    final currentAuthState = authState.valueOrNull;
    if (currentAuthState is Authenticated) {
      userName = currentAuthState.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Urbania'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(homeControllerProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeSection(
                userName: userName,
                propertyName: 'Conjunto Residencial Los Pinos',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'MÉTRICAS',
                style: AppTypography.labelSM.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              metricsAsync.when(
                data: (metrics) => _buildMetricsGrid(context, metrics),
                loading: () => _buildMetricsLoading(),
                error: (error, _) => _buildMetricsError(ref),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'ACCIONES RÁPIDAS',
                style: AppTypography.labelSM.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildQuickActions(context),
              const SizedBox(height: AppSpacing.lg),
              PropertyInfo(
                propertyName: 'Conjunto Residencial Los Pinos',
                address: 'Calle 123 # 45-67, Bogotá',
                totalUnits: 48,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Widget _buildMetricsGrid(BuildContext context, dynamic metrics) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.3,
      children: [
        MetricCard(
          title: 'Reservas Pendientes',
          value: metrics.pendingReservations.toString(),
          icon: Icons.event_available,
          color: AppColors.primaryContainer,
          onTap: () => context.push('/reservations'),
        ),
        MetricCard(
          title: 'Pagos Pendientes',
          value: metrics.pendingPayments.toString(),
          icon: Icons.payment,
          color: AppSemanticColors.warning,
          onTap: () => context.push('/payments'),
        ),
        MetricCard(
          title: 'PQRS Abiertos',
          value: metrics.openPqrs.toString(),
          icon: Icons.support_agent,
          color: AppColors.error,
          onTap: () => context.push('/pqrs'),
        ),
        MetricCard(
          title: 'Notificaciones',
          value: metrics.unreadNotifications.toString(),
          icon: Icons.notifications,
          color: AppSemanticColors.info,
          onTap: () => context.push('/notifications'),
        ),
      ],
    );
  }

  Widget _buildMetricsLoading() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.3,
      children: List.generate(
        4,
        (_) => Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppShapes.md),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsError(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(AppShapes.md),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Error al cargar métricas',
            style: AppTypography.bodyMD.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () =>
                ref.read(homeControllerProvider.notifier).refresh(),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        QuickActionTile(
          title: 'Reservas',
          subtitle: 'Zonas comunes',
          icon: Icons.event_note,
          color: AppColors.primaryContainer,
          onTap: () => context.push('/reservations'),
        ),
        const SizedBox(height: AppSpacing.sm),
        QuickActionTile(
          title: 'Pagos',
          subtitle: 'Administración mensual',
          icon: Icons.payments,
          color: AppColors.secondary,
          onTap: () => context.push('/payments'),
        ),
        const SizedBox(height: AppSpacing.sm),
        QuickActionTile(
          title: 'PQRS',
          subtitle: 'Peticiones y quejas',
          icon: Icons.support_agent,
          color: AppColors.error,
          onTap: () => context.push('/pqrs'),
        ),
        const SizedBox(height: AppSpacing.sm),
        QuickActionTile(
          title: 'Chat',
          subtitle: 'Mensajes con administración',
          icon: Icons.chat,
          color: AppSemanticColors.info,
          onTap: () => context.push('/chat'),
        ),
      ],
    );
  }
}