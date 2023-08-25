import './user.dart';

class Patient extends User {
  static const role = 'patient';

  Patient({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.telephone,
    required super.active,
  });
}
