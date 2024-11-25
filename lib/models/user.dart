class User {
  final String contactId;
  final String username;
  final String password;
  final String role;
  final String locality;
  final String street;

  User({
    required this.contactId,
    required this.username,
    required this.password,
    required this.role,
    required this.locality,
    required this.street,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'username': username,
      'password': password,
      'role': role,
      'locality': locality,
      'street': street,
    };
  }
}
