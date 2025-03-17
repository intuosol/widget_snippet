import 'package:flutter/material.dart';

import '../../widget_snippet.dart';
import '../widgets/code_view.dart';
import 'tabbed_snippet.dart';
import 'widget_preview.dart';

/// A widget that displays a widget preview and its code inline.
class InlineSnippet extends StatelessWidget {
  /// Creates a new inline snippet.
  const InlineSnippet({
    super.key,
    required this.widget,
    required this.sourceCode,
    required this.config,
  });

  /// The widget to preview.
  final Widget? widget;

  /// The source code of the widget.
  final String? sourceCode;

  /// Configuration for the widget snippet display.
  final WidgetSnippetConfig config;

  @override
  Widget build(BuildContext context) {
    switch (config.displayMode) {
      case DisplayMode.row:
        return Row(
          spacing: config.spacing,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildWidgetPreview()),
            Expanded(child: _buildCodeView(context)),
          ],
        );
      case DisplayMode.column:
        return Column(
          spacing: config.spacing,
          children: <Widget>[_buildWidgetPreview(), _buildCodeView(context)],
        );
      case DisplayMode.tabbed:
        return TabbedViewSnippet(
          widgetPreview: _buildWidgetPreview(),
          codeView: _buildCodeView(context),
        );
    }
  }

  /// Builds the widget preview part of the snippet.
  ///
  /// If the widget is null, returns an empty SizedBox.
  Widget _buildWidgetPreview() {
    if (widget == null) {
      return const SizedBox.shrink();
    }

    return WidgetPreview(
      widget: widget!,
      controller: config.screenshotController,
    );
  }

  /// Builds the code view part of the snippet.
  ///
  /// If the source code is null, returns an empty SizedBox.
  /// Uses the terminal style from the config if provided.
  Widget _buildCodeView(BuildContext context) {
    if (sourceCode == null) {
      return const SizedBox.shrink();
    }
    return CodeView(
      code: sourceCode!,
      terminalStyle: config.terminalStyle,
      maxLines: config.maxLines,
    );
  }
}
