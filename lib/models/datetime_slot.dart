import './user.dart';

class DatetimeSlot {
  final String id;
  final User doctor;
  final String slotDatetime;
  final bool isFree;

  const DatetimeSlot({
    required this.id,
    required this.doctor,
    required this.slotDatetime,
    required this.isFree,
  });
}
