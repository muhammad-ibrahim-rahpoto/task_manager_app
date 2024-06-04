class Task {
  final String id;
  final String title;

  Task({
    required this.id,
    required this.title,
  });

  // Convert a Task into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  // Extract a Task object from a Map.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
    );
  }
}