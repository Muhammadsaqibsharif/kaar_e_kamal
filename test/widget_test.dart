// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:kaar_e_kamal/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kaar_e_kamal/main.dart';

void main() {
  testWidgets('Theme toggle test', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MyApp(isDarkMode: false));

    // Verify that the app starts in light mode.
    final Finder lightModeText = find.text('Light');
    expect(lightModeText, findsOneWidget);

    // Find the toggle switch and tap it.
    final Finder switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle(); // Wait for the toggle animation to complete.

    // Verify that the app switches to dark mode.
    final Finder darkModeText = find.text('Dark');
    expect(darkModeText, findsOneWidget);
  });
}
