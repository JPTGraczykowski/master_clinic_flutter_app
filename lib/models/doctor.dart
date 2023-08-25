import './user.dart';
import './specialty.dart';
import './cabinet.dart';

class Doctor extends User {
  static const role = 'doctor';
  final Specialty specialty;
  final Cabinet cabinet;

  Doctor({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.telephone,
    required super.active,
    required this.specialty,
    required this.cabinet,
  });
}
