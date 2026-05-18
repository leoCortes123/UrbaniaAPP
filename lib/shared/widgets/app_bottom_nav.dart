import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/core/theme/app_colors.dart';

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;

    return BottomNavigationBar(
      currentIndex: _getIndex(location),
      onTap: (index) => _onTap(index, context),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryContainer,
      unselectedItemColor: AppColors.onSurfaceVariant,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_outlined),
          activeIcon: Icon(Icons.credit_card),
          label: 'Pagos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications),
          label: 'Notific.',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login_outlined),
          activeIcon: Icon(Icons.login),
          label: 'Ingresos',
        ),
      ],
    );
  }

  int _getIndex(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/payments':
        return 1;
      case '/notifications':
        return 2;
      case '/ingresos':
        return 3;
      default:
        return 0;
    }
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/payments');
      case 2:
        context.go('/notifications');
      case 3:
        context.go('/ingresos');
    }
  }
}