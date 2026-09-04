import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vuleo_learning_app/main.dart';

void main() {
  testWidgets('Role selection screen shows email, password and all roles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VuleoApp());

    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    expect(find.text('Parent'), findsOneWidget);
    expect(find.text('Teacher'), findsOneWidget);
    expect(find.text('Child'), findsOneWidget);
  });

  testWidgets('Tapping a role without credentials shows validation errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VuleoApp());

    await tester.tap(find.text('Child'));
    await tester.pumpAndSettle();

    expect(find.text('Required'), findsNWidgets(2));
    expect(find.text('Quiz'), findsNothing);
  });

  testWidgets('Entering credentials and tapping Child opens the dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VuleoApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'kid@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );
    await tester.tap(find.text('Child'));
    await tester.pumpAndSettle();

    expect(find.text('Quiz'), findsOneWidget);
    expect(find.text('Lessons'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
  });
}
