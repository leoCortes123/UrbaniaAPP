import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:urbania/core/errors/failure.dart';
import 'package:urbania/core/demo/demo_credentials.dart';
import 'package:urbania/core/storage/hive_storage.dart';
import 'package:urbania/auth/domain/entities/resident_entity.dart';

class FakeAuthDatasource {
  final HiveStorage _storage;

  FakeAuthDatasource(this._storage);

  Future<Either<Failure, ResidentEntity>> login(
      String email, String password) async {
    await Future.delayed(Duration(
        milliseconds: 300 + (DateTime.now().millisecondsSinceEpoch % 500)));

    if (!DemoCredentials.validate(email, password)) {
      return const Left(ValidationFailure('Credenciales incorrectas'));
    }

    final role = DemoCredentials.getRole(email);
    final name = DemoCredentials.getName(email);
    final unit = DemoCredentials.getUnit(email);

    final user = ResidentEntity(
      id: role == 'admin' ? 'usr_admin_001' : 'usr_resident_001',
      name: name,
      email: email,
      phone: role == 'admin' ? '3001234567' : '3007654321',
      avatarUrl: null,
      role: role,
      status: 'active',
      unit: unit,
      createdAt: DateTime(2024, 1, 1),
    );

    final token = _generateLocalToken(user);
    await _storage.write('jwt_token', token);
    await _storage.write('user_data', jsonEncode(user.toJson()));

    return Right(user);
  }

  Future<Either<Failure, void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _storage.delete('jwt_token');
    await _storage.delete('user_data');
    return const Right(null);
  }

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

  String _generateLocalToken(ResidentEntity user) {
    final header =
        base64Encode(utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'})));
    final payload = base64Encode(utf8.encode(jsonEncode({
      'sub': user.id,
      'email': user.email,
      'role': user.role,
      'exp':
          DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch,
    })));
    final signature = base64Encode(utf8.encode('urbania_demo_secret'));
    return '$header.$payload.$signature';
  }
}