import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_metrics.freezed.dart';
part 'dashboard_metrics.g.dart';

@freezed
class DashboardMetrics with _$DashboardMetrics {
  const factory DashboardMetrics({
    required int pendingReservations,
    required int pendingPayments,
    required int openPqrs,
    required int unreadNotifications,
    required String propertyName,
    required String propertyAddress,
    required int totalUnits,
  }) = _DashboardMetrics;

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) =>
      _$DashboardMetricsFromJson(json);

  factory DashboardMetrics.demo() => const DashboardMetrics(
        pendingReservations: 2,
        pendingPayments: 1,
        openPqrs: 3,
        unreadNotifications: 5,
        propertyName: 'Conjunto Residencial Los Pinos',
        propertyAddress: 'Calle 123 # 45-67, Bogotá',
        totalUnits: 48,
      );
}