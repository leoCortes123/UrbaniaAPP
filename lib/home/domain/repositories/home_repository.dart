import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../entities/dashboard_metrics.dart';

abstract class HomeRepository {
  Future<Either<Failure, DashboardMetrics>> getDashboardMetrics();
}