import 'package:freezed_annotation/freezed_annotation.dart';

part 'resident_entity.freezed.dart';
part 'resident_entity.g.dart';

@freezed
class ResidentEntity with _$ResidentEntity {
  const factory ResidentEntity({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String unit,
    String? avatarUrl,
    required String role,
    required String status,
    required DateTime createdAt,
  }) = _ResidentEntity;

  factory ResidentEntity.fromJson(Map<String, dynamic> json) =>
      _$ResidentEntityFromJson(json);
}