import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../entities/resident_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResidentEntity>> login(String email, String password);
  Future<Either<Failure, ResidentEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String unit,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, ResidentEntity?>> getCurrentUser();
}