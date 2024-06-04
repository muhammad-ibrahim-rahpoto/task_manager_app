import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/data/data_sources/task_db_helper.dart';

class SqliteTaskRepository implements TaskRepository {
  final TaskDbHelper dbHelper;

  SqliteTaskRepository(this.dbHelper);

  @override
  Future<List<Task>> getTasks() async {
    return await dbHelper.getTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    await dbHelper.insertTask(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await dbHelper.deleteTask(id);
  }
}