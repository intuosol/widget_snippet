import 'package:flutter/material.dart';

import '../widget_snippet.dart';
import 'presentation/bottom_sheet_snippet.dart';
import 'presentation/fullscreen_snippet.dart';
import 'presentation/inline_snippet.dart';
import 'presentation/popup_snippet.dart';

/// A Flutter widget that enables developers to easily showcase and share
/// snippets of their widgets in package example apps, documentation,
/// and presentations.
///
/// The WidgetSnippet package allows developers to display a widget alongside
/// its source code, making it easy to demonstrate UI components, teach Flutter
/// concepts, or create interactive documentation.
///
/// This widget supports multiple display modes:
/// - Row layout (side by side)
/// - Column layout (stacked)
/// - Tabbed layout (switchable tabs)
///
/// It can be used directly as an inline widget or through static methods
/// that provide different presentation options (bottom sheet, popup dialog,
/// or full-screen view).
class WidgetSnippet extends StatelessWidget {
  /// Creates a new widget snippet that displays inline within your UI.
  ///
  /// The [widget] parameter is the actual Flutter widget to display.
  /// The [sourceCode] parameter is the string representation of the widget's code.
  /// The [config] parameter allows customization of the display options.
  ///
  /// [config.displayMode] defaults to [DisplayMode.column].
  const WidgetSnippet({super.key, this.sourceCode, this.widget, this.config});

  /// The widget to display in the preview.
  final Widget? widget;

  /// The source code of the widget as a string.
  final String? sourceCode;

  /// Configuration options for the snippet display.
  final WidgetSnippetConfig? config;

  /// Displays a modal containing the widget preview, code snippet,
  /// and action buttons based on the screen size.
  ///
  /// This method displays a popup dialog if the screen width is greater
  /// than 600px, or a bottom sheet if the screen width is less than 600px.
  ///
  /// Parameters:
  /// * [context] - The build context
  /// * [sourceCode] - The source code to display
  /// * [widget] - Optional widget to preview
  /// * [config] - Optional configuration for the snippet
  ///
  /// [config.displayMode] dynamically changes based on the screen width and
  /// whether a [widget] is provided.
  static Future<void> showModal({
    required BuildContext context,
    required String sourceCode,
    Widget? widget,
    WidgetSnippetConfig? config,
  }) {
    if (MediaQuery.of(context).size.width > 600) {
      return showPopup(
        context: context,
        widget: widget,
        sourceCode: sourceCode,
        config: config,
      );
    }

    return showBottomSheet(
      context: context,
      widget: widget,
      sourceCode: sourceCode,
      config: config,
    );
  }

  /// Shows a bottom sheet containing the widget preview,
  /// code snippet, and action buttons.
  ///
  /// This method is ideal for mobile devices or when you want a
  /// non-intrusive way to show widget details.
  ///
  /// Parameters:
  /// * [context] - The build context
  /// * [sourceCode] - The source code to display
  /// * [widget] - Optional widget to preview
  /// * [config] - Optional configuration for the snippet
  static Future<void> showBottomSheet({
    required BuildContext context,
    required String sourceCode,
    Widget? widget,
    WidgetSnippetConfig? config,
  }) async {
    config ??= WidgetSnippetConfig();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.925,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return BottomSheetSnippet(
          widget: widget,
          sourceCode: sourceCode,
          config: config!,
        );
      },
    );
  }

  /// Displays the widget and code in a popup dialog.
  ///
  /// This method shows the widget and its source code in a centered
  /// dialog, which is ideal for desktop or tablet views.
  ///
  /// Parameters:
  /// * [context] - The build context
  /// * [sourceCode] - The source code to display
  /// * [widget] - Optional widget to preview
  /// * [config] - Optional configuration for the snippet
  ///
  /// [config.displayMode] defaults to [DisplayMode.column] when no [widget] is provided.
  /// [config.displayMode] defaults to [DisplayMode.row] when [widget] is provided and the screen width is greater than 800px.
  /// [config.displayMode] defaults to [DisplayMode.tabbed] when [widget] is provided and the screen width is less than 800px.
  static Future<void> showPopup({
    required BuildContext context,
    required String sourceCode,
    Widget? widget,
    WidgetSnippetConfig? config,
  }) async {
    // If no config is provided, create a default one with tabbed mode
    config ??= WidgetSnippetConfig();
    DisplayMode? displayMode = config.displayMode;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PopupSnippet(
          widget: widget,
          sourceCode: sourceCode,
          config: config!.copyWith(
            displayMode:
                displayMode ??=
                    widget == null
                        ? DisplayMode.column
                        : MediaQuery.of(context).size.width > 800
                        ? DisplayMode.row
                        : DisplayMode.tabbed,
          ),
        );
      },
    );
  }

  /// Navigates to a full-screen page displaying the widget and its code.
  ///
  /// This method provides a dedicated page for the widget and its code,
  /// which is ideal for in-depth exploration or presentations.
  ///
  /// Parameters:
  /// * [context] - The build context
  /// * [widget] - The widget to preview
  /// * [sourceCode] - The source code to display
  /// * [config] - Optional configuration for the snippet
  ///
  /// [config.displayMode] defaults to [DisplayMode.tabbed].
  static Future<Object> showFullScreen({
    required BuildContext context,
    required String sourceCode,
    Widget? widget,
    WidgetSnippetConfig? config,
  }) async {
    config ??= WidgetSnippetConfig();
    DisplayMode? displayMode = config.displayMode;

    return Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder:
            (BuildContext context) => FullScreenSnippet(
              widget: widget,
              sourceCode: sourceCode,
              config: config!.copyWith(
                displayMode:
                    displayMode ??=
                        widget == null
                            ? DisplayMode.column
                            : DisplayMode.tabbed,
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InlineSnippet(
      widget: widget,
      sourceCode: sourceCode,
      config: config ?? WidgetSnippetConfig(),
    );
  }
}
