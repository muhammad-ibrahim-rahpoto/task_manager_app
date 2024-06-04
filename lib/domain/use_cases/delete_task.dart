import 'package:task_manager_app/domain/repositories/task_repository.dart';
class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> execute(String id) {
    return repository.deleteTask(id);
  }
}