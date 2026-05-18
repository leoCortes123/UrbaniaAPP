import 'package:fpdart/fpdart.dart';
import 'package:urbania/core/errors/failure.dart';
import 'package:urbania/home/domain/entities/dashboard_metrics.dart';
import 'package:urbania/home/domain/repositories/home_repository.dart';
import 'package:urbania/home/data/datasources/fake/fake_home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FakeHomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, DashboardMetrics>> getDashboardMetrics() {
    return _datasource.getDashboardMetrics();
  }
}