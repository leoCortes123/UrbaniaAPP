import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../entities/resident_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, ResidentEntity>> call(String email, String password) {
    if (email.isEmpty) {
      return Future.value(
          const Left(ValidationFailure('Ingresa tu email')));
    }
    if (!email.contains('@')) {
      return Future.value(
          const Left(ValidationFailure('Ingresa un email válido')));
    }
    if (password.isEmpty) {
      return Future.value(
          const Left(ValidationFailure('Ingresa tu contraseña')));
    }
    return repository.login(email, password);
  }
}