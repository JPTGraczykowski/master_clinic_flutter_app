import 'package:json_annotation/json_annotation.dart';

part 'datetime_slot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DatetimeSlot {
  final int id;
  final String slotDatetime;
  final bool isFree;

  const DatetimeSlot({
    required this.id,
    required this.slotDatetime,
    required this.isFree,
  });

  factory DatetimeSlot.fromJson(Map<String, dynamic> json) => _$DatetimeSlotFromJson(json);
}
