import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shift_handover_challenge/features/shift_handover/shift_handover_screen.dart';
import 'package:shift_handover_challenge/di.dart' as di;

void main() {
  setUpAll(() async {
    di.setupDI();
  });

  testWidgets('ShiftHandoverScreen full flow: add, edit, delete, submit',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShiftHandoverScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Add a note by entering text and pressing Enter
    final textField = find.byType(TextField).first;
    await tester.enterText(textField, 'Integration test note');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Integration test note'), findsOneWidget);

    // Edit the note
    final editBtn = find.byIcon(Icons.edit).first;
    await tester.tap(editBtn);
    await tester.pumpAndSettle();
    final editTextField = find.byType(TextField).last;
    await tester.enterText(editTextField, 'Edited note');
    await tester.pump();
    final saveBtn = find.widgetWithText(ElevatedButton, 'Save');
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();
    expect(find.text('Edited note'), findsOneWidget);

    // Delete the note
    final deleteBtn = find.byIcon(Icons.delete).first;
    await tester.tap(deleteBtn);
    await tester.pumpAndSettle();
    expect(find.text('Edited note'), findsNothing);

    // Submit final report
    final submitBtn =
        find.widgetWithText(ElevatedButton, 'Submit Final Report');
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    final summaryField = find.byType(TextField).last;
    await tester.enterText(summaryField, 'Shift summary');
    await tester.pump();
    final dialogSubmitBtn = find.widgetWithText(ElevatedButton, 'Submit');
    await tester.tap(dialogSubmitBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Report submitted successfully!'), findsOneWidget);
  });
}
