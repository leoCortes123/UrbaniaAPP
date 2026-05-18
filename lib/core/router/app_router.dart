import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/auth/presentation/providers/auth_controller.dart';
import 'package:urbania/auth/presentation/states/auth_state.dart';
import 'package:urbania/auth/presentation/pages/login_page.dart';
import 'package:urbania/auth/presentation/pages/register_page.dart';
import 'package:urbania/auth/presentation/pages/forgot_password_page.dart';
import 'package:urbania/home/presentation/pages/home_page.dart';
import 'package:urbania/profile/presentation/pages/profile_page.dart';
import 'package:urbania/payments/presentation/pages/payments_page.dart';
import 'package:urbania/notifications/presentation/pages/notifications_page.dart';
import 'package:urbania/ingresos/presentation/pages/ingresos_page.dart';
import 'package:urbania/reservations/presentation/pages/reservations_page.dart';
import 'package:urbania/pqrs/presentation/pages/pqrs_page.dart';
import 'package:urbania/chat/presentation/pages/chat_page.dart';

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AuthState>>(
      authControllerProvider,
      (previous, next) {
        if (next is! AsyncLoading) {
          notifyListeners();
        }
      },
    );
  }
  final Ref _ref;
}

final authRouterNotifierProvider = Provider<AuthRouterNotifier>((ref) {
  return AuthRouterNotifier(ref);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(authRouterNotifierProvider);
  final authAsync = ref.watch(authControllerProvider);
  final currentAuthState = authAsync.valueOrNull;

  return GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      return _redirectLogic(currentAuthState, state.matchedLocation);
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(
          path: '/forgot-password',
          builder: (_, __) => const ForgotPasswordPage()),
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      GoRoute(path: '/payments', builder: (_, __) => const PaymentsPage()),
      GoRoute(
          path: '/notifications', builder: (_, __) => const NotificationsPage()),
      GoRoute(path: '/ingresos', builder: (_, __) => const IngresosPage()),
      GoRoute(
          path: '/reservations', builder: (_, __) => const ReservationsPage()),
      GoRoute(path: '/pqrs', builder: (_, __) => const PqrsPage()),
      GoRoute(path: '/chat', builder: (_, __) => const ChatPage()),
    ],
  );
});

String? _redirectLogic(AuthState? authState, String location) {
  final isAuthenticated = authState is Authenticated;
  final isAuthRoute = location == '/login' ||
      location == '/register' ||
      location == '/forgot-password';

  if (!isAuthenticated && !isAuthRoute) {
    return '/login';
  }
  if (isAuthenticated && isAuthRoute) {
    return '/';
  }
  return null;
}