sealed class AuthState {
  const AuthState();
}

final class Authenticated extends AuthState {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String unit;
  final String role;

  const Authenticated({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.unit,
    required this.role,
  });
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}