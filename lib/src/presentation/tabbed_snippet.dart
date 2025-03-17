import 'package:flutter/material.dart';

/// A widget that displays a widget preview and code in a tabbed interface.
///
/// This widget is useful for small screens where there isn't enough space
/// to show both the widget preview and code side by side or stacked vertically.
/// It provides tabs to switch between the widget preview and code view.
class TabbedViewSnippet extends StatelessWidget {
  /// Creates a new tabbed view snippet.
  const TabbedViewSnippet({
    super.key,
    required this.widgetPreview,
    required this.codeView,
  });

  /// The widget preview to display in the first tab.
  final Widget? widgetPreview;

  /// The code view to display in the second tab.
  final Widget codeView;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widgetPreview == null ? 1 : 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            tabs: <Widget>[
              if (widgetPreview != null) const Tab(text: 'Widget Preview'),
              const Tab(text: 'Source Code'),
            ],
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                if (widgetPreview != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widgetPreview,
                  ),
                Padding(padding: const EdgeInsets.all(16.0), child: codeView),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
