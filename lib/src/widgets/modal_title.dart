import 'package:flutter/material.dart';

/// A title bar widget for modals that displays a title and optional actions.
///
/// This widget is used in bottom sheets, popup dialogs, and other modal interfaces
/// to provide a consistent header with a title and action buttons.
class ModalTitle extends StatelessWidget {
  /// Creates a new modal title widget.
  const ModalTitle({
    super.key,
    required this.title,
    this.actions = const <Widget>[],
  });

  /// The title of the modal
  final String title;

  /// The actions for the modal
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 8),
              ...actions,
            ],
          ),
        ),
        const Divider(height: 0, thickness: 0.5),
      ],
    );
  }
}
