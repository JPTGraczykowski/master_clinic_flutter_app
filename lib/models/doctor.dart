import './user.dart';
import './specialty.dart';
import './cabinet.dart';

class Doctor extends User {
  static const role = UserRole.doctor;
  final Specialty? specialty;
  final Cabinet? cabinet;

  Doctor({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.fullName,
    required super.telephone,
    required super.active,
    this.specialty,
    this.cabinet,
  });
}
