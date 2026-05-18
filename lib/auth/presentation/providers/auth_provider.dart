import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/hive_storage.dart';
import '../../data/datasources/fake/fake_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

final hiveStorageProvider = Provider<HiveStorage>((ref) {
  return HiveStorage();
});

final fakeAuthDatasourceProvider = Provider<FakeAuthDatasource>((ref) {
  final storage = ref.watch(hiveStorageProvider);
  return FakeAuthDatasource(storage);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.watch(fakeAuthDatasourceProvider);
  return AuthRepositoryImpl(datasource);
});