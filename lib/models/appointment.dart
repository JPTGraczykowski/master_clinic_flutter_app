import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Appointment {
  final int id;
  final String appointmentDatetime;
  final String description;
  final String? beforeVisit;
  final Map<String, dynamic> specialty;
  final Map<String, dynamic> patient;
  final Map<String, dynamic> doctor;
  final Map<String, dynamic> cabinet;

  const Appointment({
    required this.id,
    required this.appointmentDatetime,
    required this.description,
    this.beforeVisit,
    required this.specialty,
    required this.patient,
    required this.doctor,
    required this.cabinet,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
