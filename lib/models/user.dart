class User {
  final String contactId;
  final String username;
  final String password;
  final String role;

  User({
    required this.contactId,
    required this.username,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
