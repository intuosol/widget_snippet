import 'package:flutter/material.dart';

import '../models/widget_snippet_config.dart';
import 'inline_snippet.dart';

/// A full-screen page that displays a widget preview and its code.
class FullScreenSnippet extends StatelessWidget {
  /// Creates a new full-screen snippet.
  const FullScreenSnippet({
    super.key,
    required this.widget,
    required this.sourceCode,
    required this.config,
  });

  /// The widget to preview.
  final Widget? widget;

  /// The source code of the widget.
  final String sourceCode;

  /// Configuration for the widget snippet display.
  final WidgetSnippetConfig config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(config.title)),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InlineSnippet(
                widget: widget,
                sourceCode: sourceCode,
                config: config,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
