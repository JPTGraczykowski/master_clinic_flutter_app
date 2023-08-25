import './doctor.dart';

class DatetimeSlot {
  final String id;
  final Doctor doctor;
  final String slotDatetime;
  final bool isFree;

  const DatetimeSlot({
    required this.id,
    required this.doctor,
    required this.slotDatetime,
    required this.isFree,
  });
}
