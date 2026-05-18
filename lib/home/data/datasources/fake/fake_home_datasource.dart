import 'package:fpdart/fpdart.dart';
import 'package:urbania/core/errors/failure.dart';
import 'package:urbania/home/domain/entities/dashboard_metrics.dart';

class FakeHomeDatasource {
  Future<Either<Failure, DashboardMetrics>> getDashboardMetrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(DashboardMetrics.demo());
  }
}