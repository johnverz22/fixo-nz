class User {
  final int id;
  final String username;
  final String email;
  final String phoneNumber;
  final String role;
  final String token;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.role,
      required this.token});
}
