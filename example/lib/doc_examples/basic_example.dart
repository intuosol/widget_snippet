import 'package:flutter/material.dart';
import 'package:widget_snippet/widget_snippet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Snippet Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

// #docregion
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Define your widget
  static final Widget myCustomWidget = Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Hello, Widget Snippet!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  // The source code for your widget
  static final String sourceCode = '''
Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Hello, Widget Snippet!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Snippet Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the widget inline
            SizedBox(
              height: 400,
              child: WidgetSnippet(
                widget: myCustomWidget,
                sourceCode: sourceCode,
              ),
            ),
            const SizedBox(height: 20),
            // Button to show the widget in a responsive modal
            ElevatedButton(
              onPressed: () {
                WidgetSnippet.showModal(
                  context: context,
                  widget: myCustomWidget,
                  sourceCode: sourceCode,
                );
              },
              child: const Text('Show in Responsive Modal'),
            ),
            const SizedBox(height: 8),
            // Button to show the widget in a bottom sheet
            ElevatedButton(
              onPressed: () {
                WidgetSnippet.showBottomSheet(
                  context: context,
                  widget: myCustomWidget,
                  sourceCode: sourceCode,
                );
              },
              child: const Text('Show in Bottom Sheet'),
            ),
            // Button to show the widget in a dialog
            ElevatedButton(
              onPressed: () {
                WidgetSnippet.showPopup(
                  context: context,
                  widget: myCustomWidget,
                  sourceCode: sourceCode,
                );
              },
              child: const Text('Show in Popup'),
            ),
            // Button to show the widget in full screen
            ElevatedButton(
              onPressed: () {
                WidgetSnippet.showFullScreen(
                  context: context,
                  widget: myCustomWidget,
                  sourceCode: sourceCode,
                );
              },
              child: const Text('Show in Full Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
