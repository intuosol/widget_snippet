import 'package:flutter/material.dart';

import '../models/terminal_style.dart';

/// A widget that displays source code in a terminal-style window.
class TerminalSnippet extends StatelessWidget {
  /// Creates a new terminal snippet.
  const TerminalSnippet({
    super.key,
    required this.codeView,
    required this.style,
  });

  /// The code view to be displayed in the terminal.
  final Widget codeView;

  /// The style applied to the terminal display.
  final TerminalStyle style;

  /// Whether the window should be dark.
  bool get _darkWindow => style.brightness == Brightness.dark;

  /// The background color of the window.
  Color get windowColor =>
      (_darkWindow ? const Color(0xFF1F1E1E) : Colors.white);

  /// The color of the title bar.
  Color get titleBarColor =>
      (_darkWindow ? const Color(0xFF373737) : const Color(0xFFEFEFEF));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: windowColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitleBar(
                context: context,
                isDark: _darkWindow,
                windowColor: windowColor,
                titleBarColor: titleBarColor,
                terminalStyle: style,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: codeView,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the title bar of the terminal window with mock window controls
  /// and a title.
  Widget _buildTitleBar({
    required BuildContext context,
    required bool isDark,
    required Color windowColor,
    required Color titleBarColor,
    required TerminalStyle terminalStyle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: titleBarColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Mock window controls
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFED6A5E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4BF4F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF61C454),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          // Title
          Text(
            terminalStyle.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
