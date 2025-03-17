import 'package:flutter/material.dart';
import 'package:widget_snippet/widget_snippet.dart';

class CustomizationExample extends StatelessWidget {
  const CustomizationExample({super.key});

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
        // The title to display for the widget preview and file name
        title: 'Customization Example',

        // How to display the widget and code
        displayMode: DisplayMode.tabbed,

        // Spacing between widget and code
        spacing: 16,

        // The maximum number of lines to show in the code view
        maxLines: 20,

        // Terminal style (for terminal display mode)
        terminalStyle: const TerminalStyle(
          title: 'Code Snippet',
          brightness: Brightness.dark,
        ),
      ),
    );
    // #enddocregion build
  }
}
