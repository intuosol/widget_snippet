import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A button that copies text to the clipboard and shows a confirmation message.
///
/// This widget is used to provide a consistent copy functionality across
/// different types of code viewers, with appropriate styling based on the
/// surrounding context (terminal or standard code view).
class CopyButton extends StatefulWidget {
  /// Creates a new copy button.
  const CopyButton({
    super.key,
    required this.textToCopy,
    required this.brightness,
    required this.terminalView,
    this.confirmationMessage = 'copied to clipboard',
  });

  /// The brightness of the color scheme.
  final Brightness brightness;

  /// The text to copy to the clipboard.
  final String textToCopy;

  /// The message to show when the code is copied.
  final String confirmationMessage;

  /// Whether or not the copy button is in the terminal view.
  final bool terminalView;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  /// Whether to show the confirmation message.
  bool showConfirmation = false;

  /// Copies the code to the clipboard and shows a confirmation message.
  /// The confirmation message disappears after a short delay.
  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.textToCopy));

    setState(() {
      showConfirmation = true;
    });

    Future<void>.delayed(Durations.extralong4, () {
      setState(() {
        showConfirmation = false;
      });
    });
  }

  /// Returns the appropriate base color based on the brightness.
  /// Used for the copy icon and confirmation background.
  Color get baseColor {
    if (widget.brightness == Brightness.dark) {
      return Colors.white60;
    } else {
      return Colors.black54;
    }
  }

  /// Returns the appropriate text color for the confirmation message
  /// based on the brightness.
  Color get textColor {
    if (widget.brightness == Brightness.dark) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: widget.terminalView ? 4.0 : 0),
          child: IconButton(
            hoverColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            onPressed: () => _copyCode(context),
            icon: Icon(Icons.copy, size: 18, color: baseColor),
          ),
        ),
        if (showConfirmation)
          Padding(
            padding: const EdgeInsets.only(right: 4.0, top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.confirmationMessage,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: textColor),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
