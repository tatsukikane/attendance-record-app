class AttendaceRecoard {
  AttendaceRecoard({
    required this.id,
    required this.totalTime,
    required this.startedAt,
    this.endedAt,
  });
  
  final int id;
  final int totalTime;
  final DateTime startedAt;
  final DateTime? endedAt;
}
