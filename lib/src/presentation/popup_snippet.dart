import 'package:flutter/material.dart';

import '../models/widget_snippet_config.dart';
import '../widgets/download_zip_button.dart';
import '../widgets/modal_title.dart';
import 'inline_snippet.dart';

/// A popup dialog that displays a widget preview and its code.
class PopupSnippet extends StatelessWidget {
  /// Creates a new popup snippet.
  const PopupSnippet({
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
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton.outlined(
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InlineSnippet(
                  widget: widget,
                  sourceCode: sourceCode,
                  config: config,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
