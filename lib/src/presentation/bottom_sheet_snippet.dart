import 'package:flutter/material.dart';

import '../models/widget_snippet_config.dart';
import '../widgets/download_zip_button.dart';
import '../widgets/modal_title.dart';
import 'inline_snippet.dart';

/// A bottom sheet that displays a widget preview and its code.
class BottomSheetSnippet extends StatelessWidget {
  /// Creates a new bottom sheet snippet.
  const BottomSheetSnippet({
    super.key,
    this.widget,
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
    return Column(
      children: <Widget>[
        ModalTitle(
          title: config.title,
          actions: <Widget>[
            DownloadZipButton(
              screenshotController: config.screenshotController,
              sourceCode: sourceCode,
              title: config.title,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InlineSnippet(
                widget: widget,
                sourceCode: sourceCode,
                config: config,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
