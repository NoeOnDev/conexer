class UpdateContact {
  final String firstName;
  final String lastName;
  final String hobby;

  UpdateContact({
    required this.firstName,
    required this.lastName,
    required this.hobby,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'hobby': hobby,
    };
  }
}
