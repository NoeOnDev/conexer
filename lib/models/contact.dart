class Contact {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String hobbit;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.hobbit,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'hobbit': hobbit,
    };
  }
}
