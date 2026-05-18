import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/hive_storage.dart';
import '../../domain/entities/resident_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../data/datasources/fake/fake_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../states/auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<AuthState> build() {
    _checkAuthStatus();
    return const AsyncValue.data(Unauthenticated());
  }

  Future<void> _checkAuthStatus() async {
    final repository = _getRepository();
    final getCurrentUser = GetCurrentUserUseCase(repository);
    final result = await getCurrentUser();

    result.fold(
      (failure) => state = const AsyncValue.data(Unauthenticated()),
      (user) {
        if (user != null) {
          state = AsyncValue.data(Authenticated(
            id: user.id,
            name: user.name,
            email: user.email,
            phone: user.phone,
            unit: user.unit,
            role: user.role,
          ));
        } else {
          state = const AsyncValue.data(Unauthenticated());
        }
      },
    );
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final repository = _getRepository();
    final loginUseCase = LoginUseCase(repository);
    final result = await loginUseCase(email, password);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (user) => AsyncValue.data(Authenticated(
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        unit: user.unit,
        role: user.role,
      )),
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();

    final repository = _getRepository();
    final logoutUseCase = LogoutUseCase(repository);
    final result = await logoutUseCase();

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (_) => const AsyncValue.data(Unauthenticated()),
    );
  }

  AuthRepository _getRepository() {
    final storage = HiveStorage();
    final datasource = FakeAuthDatasource(storage);
    return AuthRepositoryImpl(datasource);
  }
}