class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String telephone;
  final bool active;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.telephone,
    required this.active,
  });
}
