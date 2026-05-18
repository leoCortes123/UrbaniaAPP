import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/resident_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/fake/fake_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FakeAuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, ResidentEntity>> login(String email, String password) {
    return _datasource.login(email, password);
  }

  @override
  Future<Either<Failure, ResidentEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String unit,
    required String password,
  }) async {
    return const Left(BusinessLogicFailure(
      'Registro deshabilitado en modo demo. Use credenciales admin.',
    ));
  }

  @override
  Future<Either<Failure, void>> logout() {
    return _datasource.logout();
  }

  @override
  Future<Either<Failure, ResidentEntity?>> getCurrentUser() {
    return _datasource.getCurrentUser();
  }
}