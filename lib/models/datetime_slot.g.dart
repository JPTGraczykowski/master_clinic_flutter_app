// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datetime_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatetimeSlot _$DatetimeSlotFromJson(Map<String, dynamic> json) => DatetimeSlot(
      id: json['id'] as int,
      slotDatetime: json['slot_datetime'] as String,
      isFree: json['is_free'] as bool,
    );

Map<String, dynamic> _$DatetimeSlotToJson(DatetimeSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_datetime': instance.slotDatetime,
      'is_free': instance.isFree,
    };
