// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cabinet _$CabinetFromJson(Map<String, dynamic> json) => Cabinet(
      id: json['id'] as int,
      name: json['name'] as String,
      floor: json['floor'] as int,
    );

Map<String, dynamic> _$CabinetToJson(Cabinet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'floor': instance.floor,
    };
