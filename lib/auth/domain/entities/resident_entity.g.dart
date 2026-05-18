// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResidentEntityImpl _$$ResidentEntityImplFromJson(Map<String, dynamic> json) =>
    _$ResidentEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      unit: json['unit'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ResidentEntityImplToJson(
  _$ResidentEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'unit': instance.unit,
  'avatarUrl': instance.avatarUrl,
  'role': instance.role,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
};
