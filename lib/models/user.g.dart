// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      telephone: json['telephone'] as String,
      active: json['active'] as bool,
      specialtyId: json['specialty_id'] as String?,
      cabinetId: json['cabinet_id'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'role': _$UserRoleEnumMap[instance.role]!,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'telephone': instance.telephone,
      'active': instance.active,
      'specialty_id': instance.specialtyId,
      'cabinet_id': instance.cabinetId,
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.doctor: 'doctor',
  UserRole.patient: 'patient',
};
