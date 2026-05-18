// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardMetricsImpl _$$DashboardMetricsImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardMetricsImpl(
  pendingReservations: (json['pendingReservations'] as num).toInt(),
  pendingPayments: (json['pendingPayments'] as num).toInt(),
  openPqrs: (json['openPqrs'] as num).toInt(),
  unreadNotifications: (json['unreadNotifications'] as num).toInt(),
  propertyName: json['propertyName'] as String,
  propertyAddress: json['propertyAddress'] as String,
  totalUnits: (json['totalUnits'] as num).toInt(),
);

Map<String, dynamic> _$$DashboardMetricsImplToJson(
  _$DashboardMetricsImpl instance,
) => <String, dynamic>{
  'pendingReservations': instance.pendingReservations,
  'pendingPayments': instance.pendingPayments,
  'openPqrs': instance.openPqrs,
  'unreadNotifications': instance.unreadNotifications,
  'propertyName': instance.propertyName,
  'propertyAddress': instance.propertyAddress,
  'totalUnits': instance.totalUnits,
};
