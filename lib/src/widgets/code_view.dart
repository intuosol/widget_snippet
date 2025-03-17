import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
// Import the language & theme
import 'package:highlight/languages/dart.dart';

import '../models/terminal_style.dart';
import 'copy_button.dart';
import 'terminal_snippet.dart';

/// A widget that displays formatted code with syntax highlighting.
class CodeView extends StatefulWidget {
  /// Creates a new code view.
  const CodeView({
    super.key,
    required this.code,
    this.terminalStyle,
    this.language = 'dart',
    this.maxLines,
    this.showLineNumbers = true,
    this.showBackground = true,
  });

  /// The source code to display.
  final String code;

  /// The programming language of the code.
  final String language;

  /// Maximum number of lines to display.
  /// If null, all lines are displayed.
  final int? maxLines;

  /// Whether or not to show line numbers.
  /// Defaults to true.
  final bool showLineNumbers;

  /// Whether or not to show a background color.
  /// Defaults to true.
  final bool showBackground;

  /// The terminal style to use.
  final TerminalStyle? terminalStyle;

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(text: widget.code, language: dart);
  }

  Brightness _getBrightness(BuildContext context) {
    return widget.terminalStyle?.brightness ?? Theme.of(context).brightness;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildCodeView(context),
        Align(
          alignment: Alignment.topRight,
          child: CopyButton(
            textToCopy: widget.code,
            brightness: _getBrightness(context),
            terminalView: widget.terminalStyle != null,
          ),
        ),
      ],
    );
  }

  Widget _buildCodeView(BuildContext context) {
    final Map<String, TextStyle> theme =
        _getBrightness(context) == Brightness.dark ? vs2015Theme : vsTheme;

    final Widget codeView = ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: SingleChildScrollView(
        child: CodeTheme(
          data: CodeThemeData(styles: theme),
          child: CodeField(
            controller: _codeController,
            readOnly: true,
            maxLines: widget.maxLines,
            enabled: false,
          ),
        ),
      ),
    );

    if (widget.terminalStyle == null) {
      return codeView;
    }

    return TerminalSnippet(
      codeView: codeView,
      style: widget.terminalStyle!.copyWith(
        brightness: _getBrightness(context),
      ),
    );
  }
}
