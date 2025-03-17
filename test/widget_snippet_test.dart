// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Using a direct import of widget_snippet.dart to bypass the downloader.dart import
// which contains web-specific code that fails in the test environment
import 'package:widget_snippet/src/constants/display_mode.dart';
import 'package:widget_snippet/src/models/widget_snippet_config.dart';
import 'package:widget_snippet/src/widget_snippet.dart';

void main() {
  group('WidgetSnippet', () {
    final Container testWidget = Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: const Center(child: Text('Test Widget')),
    );

    const String sourceCode = '''
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
  child: const Center(
    child: Text('Test Widget'),
  ),
)
''';

    testWidgets('renders inline widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WidgetSnippet(widget: testWidget, sourceCode: sourceCode),
          ),
        ),
      );

      // Verify widget is displayed
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('renders with custom display mode', (
      WidgetTester tester,
    ) async {
      final WidgetSnippetConfig config = WidgetSnippetConfig(
        displayMode: DisplayMode.row,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WidgetSnippet(
              widget: testWidget,
              sourceCode: sourceCode,
              config: config,
            ),
          ),
        ),
      );

      // Verify widget is displayed
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('accepts null widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WidgetSnippet(sourceCode: sourceCode)),
        ),
      );

      // Widget should not be displayed
      expect(find.text('Test Widget'), findsNothing);
    });

    testWidgets('accepts null sourceCode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WidgetSnippet(widget: testWidget))),
      );

      // Verify widget is displayed
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('uses default config when none provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WidgetSnippet(widget: testWidget, sourceCode: sourceCode),
          ),
        ),
      );

      // Verify widget is displayed
      expect(find.text('Test Widget'), findsOneWidget);
    });
  });
}
