import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/domain/use_cases/delete_task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:mockito/annotations.dart';
import 'delete_task_test.mocks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/presentation/providers/task_provider.dart';

@GenerateMocks([TaskRepository])
void main() {
  test('DeleteTask use case should delete a task', () async {
    final repository = MockTaskRepository();
    final container = ProviderContainer(overrides: [
      taskRepositoryProvider.overrideWithValue(repository),
    ]);
    final useCase = DeleteTask(container.read(taskRepositoryProvider));

    final taskId = '1';
    await useCase.execute(taskId);

    // Verify that the deleteTask method is called with the correct taskId
    verify(repository.deleteTask(taskId)).called(1);

    // Dispose the container after the test
    container.dispose();
  });
}
