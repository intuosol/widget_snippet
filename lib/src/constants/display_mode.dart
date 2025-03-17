/// Display mode for widget snippets.
///
/// Determines how the widget and code are displayed in the snippet.
enum DisplayMode {
  /// Widget and code side by side (horizontal layout).
  row,

  /// Widget above the code (vertical layout).
  column,

  /// Switch between widget and code with tabs.
  /// Useful for small screens or when space is limited.
  tabbed,
}
