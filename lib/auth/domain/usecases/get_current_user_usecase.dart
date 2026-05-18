import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../entities/resident_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, ResidentEntity?>> call() =>
      repository.getCurrentUser();
}