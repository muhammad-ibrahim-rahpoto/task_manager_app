import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/presentation/views/task_list_view.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize the sqflite_ffi database factory before running tests
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('TaskListView UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TaskListView(),
        ),
      ),
    );

    // Find the app bar title
    expect(find.text('Task Manager App'), findsOneWidget);

    // Find the floating action button
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Try tapping on the floating action button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // After tapping the FAB, an AlertDialog should appear
    expect(find.byType(AlertDialog), findsOneWidget);

    // Try adding a task with the AlertDialog
    await tester.enterText(find.byType(TextField), 'Test Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // After adding a task, it should appear in the list
    expect(find.text('Test Task'), findsOneWidget);
  });
}
