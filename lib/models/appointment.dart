import 'package:intl/intl.dart';

import './specialty.dart';
import './user.dart';
import './cabinet.dart';

class Appointment {
  final String id;
  final String dateTime;
  final String description;
  final String beforeVisit;
  final Specialty specialty;
  final User patient;
  final User doctor;
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
}
