class Task {
  final String title;
  final String description;
  final DateTime startDateTime;
  final DateTime completionDateTime;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.startDateTime,
    required this.completionDateTime,
    this.isCompleted = false,
  });
}
