import 'package:flutter/material.dart';
import 'package:widget_snippet/widget_snippet.dart';

class TerminalExample extends StatelessWidget {
  const TerminalExample({super.key});

  @override
  Widget build(BuildContext context) {
    final myCustomWidget = Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Hello, Widget Snippet!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    const sourceCode = '''
Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16),
  ),
  child: const Center(
    child: Text(
      'Hello, Widget Snippet!',
      style: TextStyle(color: Colors.white),
    ),
  ),
)
''';

    // #docregion build
    return WidgetSnippet(
      widget: myCustomWidget,
      sourceCode: sourceCode,
      config: WidgetSnippetConfig(
        terminalStyle: const TerminalStyle(
          title: 'Flutter Terminal',
          brightness: Brightness.dark,
        ),
      ),
    );
    // #enddocregion build
  }
}
