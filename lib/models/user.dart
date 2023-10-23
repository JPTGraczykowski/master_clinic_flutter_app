import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum UserRole {
  admin,
  doctor,
  patient,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String id;
  final UserRole role;
  final String email;
  final String firstName;
  final String lastName;
  final String telephone;
  final bool active;
  final String? specialtyId;
  final String? cabinetId;

  const User({
    required this.id,
    required this.role,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.telephone,
    required this.active,
    this.specialtyId,
    this.cabinetId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get fullName {
    return '$firstName $lastName';
  }
}
