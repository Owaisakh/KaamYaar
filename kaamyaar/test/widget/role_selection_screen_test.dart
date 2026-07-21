import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaamyaar/features/auth/presentation/role_selection_screen.dart';

void main() {
  testWidgets('RoleSelectionScreen shows two role buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RoleSelectionScreen(),
        ),
      ),
    );

    // Verify title
    expect(find.text('Choose Your Role'), findsOneWidget);

    // Verify buttons
    expect(find.text('I am a Customer'), findsOneWidget);
    expect(find.text('I am a Worker'), findsOneWidget);
  });
}
