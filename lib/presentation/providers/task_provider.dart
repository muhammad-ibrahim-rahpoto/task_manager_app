import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/domain/use_cases/add_task.dart';
import 'package:task_manager_app/domain/use_cases/get_task.dart';
import 'package:task_manager_app/domain/use_cases/delete_task.dart';
import 'package:task_manager_app/data/repositories/sqlite_task_repository.dart';
import 'package:task_manager_app/data/data_sources/task_db_helper.dart';

// Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return SqliteTaskRepository(TaskDbHelper());
});

// Use Case Providers
final addTaskProvider = Provider<AddTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return AddTask(repository);
});

final getTasksProvider = Provider<GetTasks>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetTasks(repository);
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeleteTask(repository);
});

// TasksNotifier Provider with updated name
final taskListNotifierProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final getTasks = ref.watch(getTasksProvider);
  final addTask = ref.watch(addTaskProvider);
  final deleteTask = ref.watch(deleteTaskProvider);
  return TasksNotifier(getTasks, addTask, deleteTask);
});

class TasksNotifier extends StateNotifier<List<Task>> {
  final GetTasks _getTasks;
  final AddTask _addTask;
  final DeleteTask _deleteTask;

  TasksNotifier(this._getTasks, this._addTask, this._deleteTask) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _getTasks.execute();
    state = tasks;
  }

  Future<void> addTask(String title) async {
    final newTask = Task(id: UniqueKey().toString(), title: title);
    state = [...state, newTask];
    await _addTask.execute(title);
    await _loadTasks();  // Reload tasks to synchronize with the database
  }

  Future<void> removeTask(String id) async {
    state = state.where((task) => task.id != id).toList();
    await _deleteTask.execute(id);
    await _loadTasks();  // Reload tasks to synchronize with the database
  }
}
