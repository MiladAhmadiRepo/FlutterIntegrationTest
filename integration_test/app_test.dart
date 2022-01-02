import 'package:flutter_integration_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets( "Not inputting a text and wanting to go to the display page shows "
      "an error and prevents from going to the display page.",
  (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TypingPage),findsOneWidget);
    expect(find.byType(DisplayPage),findsNothing);
    expect(find.text('Input at least one character'),findsOneWidget);
  });
  testWidgets( "After inputting a text, go to the display page which contains that same text "
      "and then navigate back to the typing page where the input should be clear",
          (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        final inputText = 'Hello there, this is an input.';
        await tester.enterText(find.byKey(Key('your-text-field')), inputText);


        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        expect(find.byType(TypingPage),findsNothing);
        expect(find.byType(DisplayPage),findsOneWidget);
        expect(find.text(inputText),findsOneWidget);

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        expect(find.byType(TypingPage),findsOneWidget);
        expect(find.byType(DisplayPage),findsNothing);
        expect(find.text(inputText),findsNothing);

  });
  // group('end-to-end test', () {
  //   testWidgets('tap on the floating action button, verify counter',
  //           (WidgetTester tester) async {
  //         app.main();
  //         await tester.pumpAndSettle();
  //
  //         // Verify the counter starts at 0.
  //         expect(find.text('0'), findsOneWidget);
  //
  //         // Finds the floating action button to tap on.
  //         final Finder fab = find.byTooltip('Increment');
  //
  //         // Emulate a tap on the floating action button.
  //         await tester.tap(fab);
  //
  //         // Trigger a frame.
  //         await tester.pumpAndSettle();
  //
  //         // Verify the counter increments by 1.
  //         expect(find.text('1'), findsOneWidget);
  //       });
  // });
}