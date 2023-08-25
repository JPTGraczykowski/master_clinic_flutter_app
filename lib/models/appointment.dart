import 'package:intl/intl.dart';

import './specialty.dart';
import './patient.dart';
import './doctor.dart';
import './cabinet.dart';

class Appointment {
  final String id;
  final String dateTime;
  final String description;
  final String beforeVisit;
  final Specialty specialty;
  final Patient patient;
  final Doctor doctor;
  final Cabinet cabinet;

  const Appointment({
    required this.id,
    required this.dateTime,
    required this.description,
    required this.beforeVisit,
    required this.specialty,
    required this.patient,
    required this.doctor,
    required this.cabinet,
  });

  String formattedDateTime(String stringDateTime) {
    DateTime dateTime = DateTime.parse(stringDateTime);

    return DateFormat('MMMM dd HH:mm').format(dateTime);
  }
}
