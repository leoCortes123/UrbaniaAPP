import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:urbania/core/errors/failure.dart';
import 'package:urbania/home/domain/entities/dashboard_metrics.dart';
import 'package:urbania/home/domain/repositories/home_repository.dart';
import 'package:urbania/home/data/datasources/fake/fake_home_datasource.dart';
import 'package:urbania/home/data/repositories/home_repository_impl.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  AsyncValue<DashboardMetrics> build() {
    _loadMetrics();
    return const AsyncValue.loading();
  }

  Future<void> _loadMetrics() async {
    final datasource = FakeHomeDatasource();
    final repository = HomeRepositoryImpl(datasource);
    final result = await repository.getDashboardMetrics();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (metrics) => state = AsyncValue.data(metrics),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadMetrics();
  }
}