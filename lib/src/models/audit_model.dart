class AuditEntry {
  final String user;
  final String action;
  final DateTime timestamp;

  AuditEntry({
    required this.user,
    required this.action,
    required this.timestamp,
  });

  factory AuditEntry.fromJson(Map<String, dynamic> json) {
    return AuditEntry(
      user: json['user'],
      action: json['action'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  String get formatted => '$user $action - ${timestamp.toString()}';
}
