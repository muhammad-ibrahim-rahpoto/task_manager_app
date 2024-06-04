import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> execute(String title) {
    final task = Task(id: Uuid().v4(), title: title);
    return repository.addTask(task);
  }
}