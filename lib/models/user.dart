class User {
  final String contactId;
  final String username;
  final String password;

  User({
    required this.contactId,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'username': username,
      'password': password,
    };
  }
}
