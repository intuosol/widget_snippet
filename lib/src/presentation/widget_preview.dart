import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

/// A widget that displays a preview of another widget.
class WidgetPreview extends StatelessWidget {
  /// Creates a new widget preview.
  const WidgetPreview({
    super.key,
    required this.widget,
    required this.controller,
    this.backgroundColor,
    this.includeBorder = true,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The widget to preview.
  final Widget widget;

  /// Controller for taking screenshots of the widget.
  final ScreenshotController controller;

  /// Background color of the preview.
  /// If null, uses the app's surface color.
  final Color? backgroundColor;

  /// Whether to include a border around the widget.
  final bool includeBorder;

  /// Border radius of the preview.
  final double borderRadius;

  /// Padding around the widget.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color actualBackgroundColor =
        backgroundColor ?? theme.colorScheme.surface;

    final Widget previewWidget = AbsorbPointer(
      child: Material(
        color: actualBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding,
          child: FittedBox(fit: BoxFit.scaleDown, child: widget),
        ),
      ),
    );

    final Widget decoratedWidget =
        includeBorder
            ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: previewWidget,
            )
            : previewWidget;

    return Screenshot(controller: controller, child: decoratedWidget);
  }
}
