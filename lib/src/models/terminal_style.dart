import 'package:flutter/material.dart';

/// Style for the terminal display mode.
class TerminalStyle {
  /// Creates a new terminal style.
  const TerminalStyle({this.title = '', this.brightness});

  /// Title of the terminal window.
  final String title;

  /// Whether or not to use a dark theme for the terminal window.
  ///
  /// Defaults to the app's theme.
  final Brightness? brightness;

  /// Create a copy of this style with the given fields replaced.
  TerminalStyle copyWith({String? title, Brightness? brightness}) {
    return TerminalStyle(title: title ?? this.title, brightness: brightness);
  }
}
