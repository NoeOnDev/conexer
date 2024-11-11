class Verify {
  final String userId;
  final String code;

  Verify({
    required this.userId,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'code': code,
    };
  }
}
