import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/2_application/app/todo_app.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TodoApp());

    expect(find.text('1'), findsNothing);
  });
}
