import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/use_cases/add_task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:mockito/annotations.dart';
import 'add_task_test.mocks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/presentation/providers/task_provider.dart';

@GenerateMocks([TaskRepository])
void main() {
  test('AddTask use case should add a task', () async {
    final repository = MockTaskRepository();
    final container = ProviderContainer(overrides: [
      taskRepositoryProvider.overrideWithValue(repository),
    ]);
    final useCase = AddTask(container.read(taskRepositoryProvider));

    final taskTitle = 'Test Task';
    await useCase.execute(taskTitle);

    // Verify that the addTask method is called with a Task object
    verify(repository.addTask(argThat(isA<Task>()))).called(1);

    // Dispose the container after the test
    container.dispose();
  });
}
