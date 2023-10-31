// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as int,
      appointmentDatetime: json['appointment_datetime'] as String,
      description: json['description'] as String,
      beforeVisit: json['before_visit'] as String?,
      specialty: json['specialty'] as Map<String, dynamic>,
      patient: json['patient'] as Map<String, dynamic>,
      doctor: json['doctor'] as Map<String, dynamic>,
      cabinet: json['cabinet'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_datetime': instance.appointmentDatetime,
      'description': instance.description,
      'before_visit': instance.beforeVisit,
      'specialty': instance.specialty,
      'patient': instance.patient,
      'doctor': instance.doctor,
      'cabinet': instance.cabinet,
    };
