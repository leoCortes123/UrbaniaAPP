# 🔐 FEATURE_AUTH
## Documentación del Feature de Autenticación

> **Consultar**: Cuando trabajes en el feature de autenticación o su navegación.
> **Relacionado con**: FEATURES_INDEX.md, DEMO_SETUP.md
>
> ⚠️ **DISEÑO VISUAL**: Antes de implementar la UI, consulta los recursos de diseño en `./recursos/`:
> - `code.html` → Mockup interactivo (fuente visual de verdad)
> - `DESIGN.md` → Especificaciones técnicas
> - `screen.png` → Captura estática
>
> NO implementes la UI basándote en suposiciones. El archivo `code.html` es la referencia visual oficial.

---

## 1. Diagrama de Flujo de Autenticación

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AUTHENTICATION FLOW                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   APP START                                                                  │
│       │                                                                     │
│       ▼                                                                     │
│   ┌─────────┐                                                                │
│   │ Login   │                                                                │
│   │  Page   │                                                                │
│   └────┬────┘                                                                │
│        │                                                                     │
│        │ On app start: check auth status                                    │
│        │ (AuthController.build() verifica sesión guardada)                   │
│        ▼                                                                     │
│   ┌─────────────┐      ┌─────────────────┐                                  │
│   │ getCurrent │ ───► │ User stored?    │                                  │
│   │   User     │      └────────┬─────────┘                                  │
│   └──────┬─────┘               │                        │                    │
│          │                    │ Yes                    │ No                 │
│          │                    ▼                        ▼                    │
│          │             ┌────────────┐           ┌──────────────┐             │
│          │             │ Home Page │           │ Login Page   │             │
│          │             │   (/ )    │           │   (/login)   │             │
│          │             └────────────┘           └──────┬───────┘             │
│          │                                            │                     │
│          │                                            │ On login success    │
│          │                                            ▼                     │
│          │                                     ┌────────────┐              │
│          │                                     │ LoginUseCase│              │
│          │                                     └──────┬─────┘              │
│          │                                            │                     │
│          │                                   validate │ credentials         │
│          │                                            ▼                     │
│          │                              ┌─────────────────────┐             │
│          │                              │ FakeAuthRepository  │             │
│          │                              └──────────┬──────────┘             │
│          │                                         │                       │
│          │                              simulate │ delay (300-800ms)      │
│          │                                         ▼                       │
│          │                              ┌─────────────────────┐            │
│          │                              │ Validate Demo       │            │
│          │                              │ Credentials         │            │
│          │                              └──────────┬──────────┘            │
│          │                                         │                        │
│          │                    ┌─────────────────────┼─────────────────┐       │
│          │                    │                                       │       │
│          │                    ▼                                       ▼       │
│          │           ┌────────────────┐                    ┌─────────────┐  │
│          │           │   Success     │                    │   Error     │  │
│          │           │ Generate JWT  │                    │ Show Error  │  │
│          │           │ Store in Hive │                    │ Alert       │  │
│          │           └───────┬───────┘                    └─────────────┘  │
│          │                   │                                            │
│          │                   ▼                                            │
│          │           ┌────────────────┐                                  │
│          │           │ AuthController │                                  │
│          │           │ state =        │                                  │
│          │           │ Authenticated  │                                  │
│          │           └───────┬────────┘                                  │
│          │                   │                                            │
│          │                   ▼                                            │
│          │           ┌────────────────┐                                  │
│          └──────────►│ Home Page (/)  │                                  │
│                      └────────────────┘                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Estados de Auth

### 2.1 Diagrama de Estados

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AUTH STATE MACHINE                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                                                                             │
│                     ┌──────────────────┐                                    │
│                     │                  │                                    │
│                     │  AuthLoading     │                                    │
│                     │                  │                                    │
│                     └────────┬─────────┘                                    │
│                              │                                              │
│                              │ _checkAuthStatus()                           │
│                              │ login() success                              │
│                              ▼                                              │
│                     ┌──────────────────┐                                    │
│                     │                  │                                    │
│                     │  Authenticated  │◄─────────────────────────────┐    │
│                     │  (user: Resident)│                              │    │
│                     └──────────────────┘                              │    │
│                              │                                         │    │
│                              │ logout()                                 │    │
│                              │                                          │    │
│                              ▼                                          │    │
│                     ┌──────────────────┐                              │    │
│                     │                  │                              │    │
│                     │ Unauthenticated  │──────────────────────────────┘    │
│                     │                  │                                    │
│                     └──────────────────┘                                    │
│                              │                                              │
│                              │ login() attempt                             │
│                              ▼                                              │
│                     ┌──────────────────┐                                    │
│                     │                  │                                    │
│                     │  AuthLoading     │                                    │
│                     │                  │                                    │
│                     └──────────────────┘                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Implementación de Estados

```dart
// lib/auth/presentation/states/auth_state.dart

sealed class AuthState {
  const AuthState();
}

/// Usuario autenticado correctamente
final class Authenticated extends AuthState {
  final ResidentEntity user;
  const Authenticated(this.user);
}

/// Sin sesión activa (logged out)
final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Verificando estado de autenticación
final class AuthLoading extends AuthState {
  const AuthLoading();
}
```

---

## 3. Providers y su Orden de Dependencia

### 3.1 Diagrama de Dependencias

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RIVERPOD DEPENDENCY GRAPH                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   NIVEL 1: INFRAESTRUCTURA (sin dependencias)                               │
│   ┌────────────────────────────────────────────────────────────────────┐   │
│   │  hiveStorageProvider: Provider<HiveStorage>                       │   │
│   └────────────────────────────────────────────────────────────────────┘   │
│                                    │                                          │
│                                    ▼                                          │
│   NIVEL 2: REPOSITORIES (depende de infraestructura)                        │
│   ┌────────────────────────────────────────────────────────────────────┐   │
│   │  authRepositoryProvider: Provider<AuthRepository>                │   │
│   │       └─ usa: hiveStorageProvider                                 │   │
│   └────────────────────────────────────────────────────────────────────┘   │
│                                    │                                          │
│                                    ▼                                          │
│   NIVEL 3: USE CASES (dependen de repositories)                            │
│   ┌────────────────────────────────────────────────────────────────────┐   │
│   │  loginUseCaseProvider: Provider<LoginUseCase>                     │   │
│   │       └─ usa: authRepositoryProvider                              │   │
│   │  logoutUseCaseProvider: Provider<LogoutUseCase>                   │   │
│   │       └─ usa: authRepositoryProvider                              │   │
│   │  getCurrentUserUseCaseProvider: Provider<GetCurrentUserUseCase>   │   │
│   │       └─ usa: authRepositoryProvider                              │   │
│   └────────────────────────────────────────────────────────────────────┘   │
│                                    │                                          │
│                                    ▼                                          │
│   NIVEL 4: CONTROLLER (AsyncNotifier - API moderna)                        │
│   ┌────────────────────────────────────────────────────────────────────┐   │
│   │  authControllerProvider: AsyncNotifierProvider<AuthController,   │   │
│   │                           AsyncValue<AuthState>>                   │   │
│   │       └─ usa: loginUseCaseProvider, logoutUseCaseProvider,        │   │
│   │                 getCurrentUserUseCaseProvider                      │   │
│   └────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Código de Providers (AsyncNotifier - API Moderna)

```dart
// lib/auth/presentation/providers/auth_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failure.dart';
import '../../domain/entities/resident_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';

part 'auth_controller.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// NIVEL 1: INFRAESTRUCTURA
// ═══════════════════════════════════════════════════════════════════════════

final hiveStorageProvider = Provider<HiveStorage>((ref) {
  return HiveStorage();
});

// ═══════════════════════════════════════════════════════════════════════════
// NIVEL 2: REPOSITORY
// ═══════════════════════════════════════════════════════════════════════════

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final storage = ref.watch(hiveStorageProvider);
  return FakeAuthRepository(storage);
});

// ═══════════════════════════════════════════════════════════════════════════
// NIVEL 3: USE CASES
// ═══════════════════════════════════════════════════════════════════════════

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

// ═══════════════════════════════════════════════════════════════════════════
// NIVEL 4: CONTROLLER (AsyncNotifier)
// ═══════════════════════════════════════════════════════════════════════════

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<AuthState> build() {
    // Verificar sesión guardada al iniciar
    _checkAuthStatus();
    return const AsyncValue.data(AuthState.unauthenticated());
  }

  /// Verifica si hay un usuario guardado en storage
  Future<void> _checkAuthStatus() async {
    final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
    final result = await getCurrentUser();

    result.fold(
      (failure) => state = const AsyncValue.data(AuthState.unauthenticated()),
      (user) {
        if (user != null) {
          state = AsyncValue.data(AuthState.authenticated(user));
        } else {
          state = const AsyncValue.data(AuthState.unauthenticated());
        }
      },
    );
  }

  /// Login con email y password
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase(email, password);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (user) => AsyncValue.data(AuthState.authenticated(user)),
    );
  }

  /// Logout
  Future<void> logout() async {
    state = const AsyncValue.loading();

    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final result = await logoutUseCase();

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (_) => const AsyncValue.data(AuthState.unauthenticated()),
    );
  }
}
```

---

## 4. FakeAuthRepository - Cómo Simula la API

### 4.1 Implementación

```dart
// lib/auth/data/repositories/fake_auth_repository.dart

class FakeAuthRepository implements AuthRepository {
  final HiveStorage _storage;

  /// Simula latencia de red variable (300-800ms)
  final _delay = Duration(
    milliseconds: 300 + (DateTime.now().millisecondsSinceEpoch % 500),
  );

  FakeAuthRepository(this._storage);

  @override
  Future<Either<Failure, ResidentEntity>> login(String email, String password) async {
    // Simula delay de red
    await Future.delayed(_delay);

    // Validar credenciales demo
    if (!DemoCredentials.validate(email, password)) {
      return const Left(ValidationFailure('Credenciales incorrectas'));
    }

    // Obtener rol y datos del usuario
    final role = DemoCredentials.getRole(email);
    final name = DemoCredentials.getName(email);
    final unit = DemoCredentials.getUnit(email);

    // Crear usuario
    final user = ResidentEntity(
      id: role == UserRole.admin ? 'usr_admin_001' : 'usr_resident_001',
      name: name,
      email: email,
      phone: role == UserRole.admin ? '3001234567' : '3007654321',
      avatarUrl: null,
      role: role,
      status: ResidentStatus.active,
      unit: unit,
      createdAt: DateTime(2024, 1, 1),
    );

    // Generar JWT local y guardar
    final token = _generateLocalToken(user);
    await _storage.write('jwt_token', token);
    await _storage.write('user_data', jsonEncode(user.toJson()));

    return Right(user);
  }

  @override
  Future<Either<Failure, ResidentEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String unit,
    required String password,
  }) async {
    await Future.delayed(_delay);
    return const Left(
      BusinessLogicFailure(
        'Registro deshabilitado en modo demo. Use credenciales admin.',
      ),
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _storage.delete('jwt_token');
    await _storage.delete('user_data');
    return const Right(null);
  }

  @override
  Future<Either<Failure, ResidentEntity?>> getCurrentUser() async {
    final userJson = await _storage.read('user_data');
    if (userJson == null) return const Right(null);

    try {
      final user = ResidentEntity.fromJson(jsonDecode(userJson));
      return Right(user);
    } catch (_) {
      return const Right(null);
    }
  }

  /// Genera JWT local para demo (NO usar en producción)
  String _generateLocalToken(ResidentEntity user) {
    final header = base64Encode(
      utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'})),
    );
    final payload = base64Encode(
      utf8.encode(jsonEncode({
        'sub': user.id,
        'email': user.email,
        'role': user.role.name,
        'exp': DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch,
      })),
    );
    // Firma dummy (no es criptográficamente segura, solo para demo)
    final signature = base64Encode(utf8.encode('urbania_demo_secret'));
    return '$header.$payload.$signature';
  }
}
```

### 4.2 Simulación de Errores

| Escenario | Resultado | Mensaje |
|----------|-----------|---------|
| Credenciales inválidas | `Left(ValidationFailure)` | Credenciales incorrectas |
| Login exitoso | `Right(ResidentEntity)` | Usuario creado |
| Logout exitoso | `Right(null)` | - |

---

## 5. Pantallas - Diseño Visual

> ⚠️ **Esta sección ha sido deprecada. Para ver el diseño visual de las pantallas, consulta los recursos de diseño.**

### Recursos de Diseño

| Pantalla | Archivo de Referencia |
|----------|----------------------|
| Login | `./recursos/code.html` |
| Diseño técnico | `./recursos/DESIGN.md` |
| Preview | `./recursos/screen.png` |

### Implementación

Para implementar la UI de Login, sigue las especificaciones visuales del `code.html` y los tokens de diseño del `DESIGN.md`. Usa los componentes base definidos en THEME_SYSTEM.md (AppButton, AppTextField, etc.).

**Flujo de Pantallas**:
```
Login → Home (on success)
```

**Notas de Implementación**:
- El formulario de login debe incluir: email, contraseña, botón de olvido de contraseña
- Botones sociales (Google, Facebook, Apple) van después del divider
- El mockup en `code.html` muestra la estructura exacta de layout

---

## 6. Validaciones de Login

### 6.1 Validaciones en UseCase

```dart
// lib/auth/domain/usecases/login_usecase.dart

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, ResidentEntity>> call(String email, String password) {
    // 1. Validar email no vacío
    if (email.isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Ingresa tu email')),
      );
    }

    // 2. Validar formato de email
    if (!email.contains('@')) {
      return Future.value(
        const Left(ValidationFailure('Ingresa un email válido')),
      );
    }

    // 3. Validar password no vacío
    if (password.isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Ingresa tu contraseña')),
      );
    }

    // 4. Delegar al repository
    return repository.login(email, password);
  }
}
```

### 6.2 Validaciones en UI

```dart
// Validación inline en LoginPage

void _handleLogin() {
  setState(() {
    _emailError = _emailController.text.isEmpty ? 'Ingresa tu email' : null;
    _passwordError = _passwordController.text.isEmpty ? 'Ingresa tu contraseña' : null;
  });

  if (_emailError != null || _passwordError != null) return;

  // Proceder con login
  ref.read(authControllerProvider.notifier).login(
    _emailController.text,
    _passwordController.text,
  );
}
```

---

## 6.5 Patrón GoRouter + Riverpod (CRÍTICO)

> **⚠️ Este patrón está documentado completamente en `/docs/ROUTING.md`**
> 
> El `redirect` de GoRouter requiere `refreshListenable` con un `ChangeNotifier` 
> que escuche cambios del `authControllerProvider`. Sin esto, el login parece 
> funcionar pero la navegación no ocurre.
> 
> Ver implementación completa en `/core/router/app_router.dart` en `/docs/ROUTING.md`.

---

## 7. Rutas Asociadas

| Ruta | Pantalla | Auth Requerida | Descripción |
|------|----------|----------------|-------------|
| `/login` | LoginPage | No | Login de usuario |
| `/register` | RegisterPage | No | Registro (pendiente) |
| `/forgot-password` | ForgotPasswordPage | No | Recuperar contraseña (pendiente) |

---

## 8. Tests

| Test | Estado | Descripción |
|------|--------|-------------|
| `login_usecase_test.dart` | ✅ Implementado | Tests de validación y éxito |
| `logout_usecase_test.dart` | ✅ Implementado | Tests de logout |
| `fake_auth_repository_test.dart` | ✅ Implementado | Tests de repository |
| `auth_controller_test.dart` | ✅ Implementado | Tests de AsyncNotifier |
| `login_page_test.dart` | ⏳ Pendiente | Tests de widget |

---

## 9. Referencias Cruzadas

| Documento | Sección Relevante |
|-----------|-------------------|
| ARCHITECTURE.md | Flujo de datos, Repository pattern, AsyncNotifier |
| DEMO_SETUP.md | FakeRepository, credenciales demo, JWT local |
| ROUTING.md | Configuración de rutas, flujo de inicio en login |
| THEME_SYSTEM.md | AppButton, AppTextField, colores, tipografía |
| ALERT_SYSTEM.md | Manejo de errores visuales |
