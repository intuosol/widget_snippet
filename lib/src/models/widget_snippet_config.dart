import 'package:screenshot/screenshot.dart';
import '../constants/display_mode.dart';
import 'terminal_style.dart';

/// Configuration for widget snippet displays.
class WidgetSnippetConfig {
  /// Creates a new widget snippet configuration.
  WidgetSnippetConfig({
    this.title = 'Widget Snippet',
    this.displayMode,
    this.spacing = 16,
    this.maxLines,
    this.terminalStyle,
  });

  /// Title for the widget preview and file download.
  final String title;

  /// How to display the widget and code.
  final DisplayMode? displayMode;

  /// Maximum number of lines to display in the code view.
  /// If null, all lines are displayed.
  final int? maxLines;

  /// Style for the terminal display mode.
  final TerminalStyle? terminalStyle;

  /// The amount of space between the widget and code.
  final double spacing;

  /// The screenshot controller for the widget preview.
  final ScreenshotController screenshotController = ScreenshotController();

  /// Create a copy of this config with the given fields replaced.
  WidgetSnippetConfig copyWith({
    String? title,
    DisplayMode? displayMode,
    double? spacing,
    int? maxLines,
    TerminalStyle? terminalStyle,
  }) {
    return WidgetSnippetConfig(
      title: title ?? this.title,
      displayMode: displayMode ?? this.displayMode,
      spacing: spacing ?? this.spacing,
      maxLines: maxLines ?? this.maxLines,
      terminalStyle: terminalStyle ?? this.terminalStyle,
    );
  }
}
