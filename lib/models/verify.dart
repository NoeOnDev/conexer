class Verify {
  final String userId;
  final String code;
  final String eventType;

  Verify({
    required this.userId,
    required this.code,
    required this.eventType,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'code': code,
      'eventType': eventType,
    };
  }
}

class ResendNotification {
  final String userId;
  final String notificationType;

  ResendNotification({
    required this.userId,
    required this.notificationType,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'notificationType': notificationType,
    };
  }
}
