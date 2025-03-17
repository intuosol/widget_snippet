## 0.1.1

- Fixed the download zip file function to download just the code file if no widget is provided.
- Fixed issue with the default DisplayMode not being auto-assigned if `WidgetSnippetConfig` is provided without `displayMode`.
- Removed the Widget Preview tab from the `DisplayMode.tabbed` mode if no widget is provided.
- Fixed `DisplayMode.tabbed` breaking when displayed in the BottomSheet.

## 0.1.0

- First public release of the Widget Snippet package
- Added multiple display methods:
  - Bottom sheet display (`WidgetSnippet.showBottomSheet`)
  - Full-screen display (`WidgetSnippet.showFullScreen`)
  - Popup dialog display (`WidgetSnippet.showPopup`)
  - Smart modal display (`WidgetSnippet.showModal`) - automatically chooses between popup and bottom sheet
  - Inline display (`WidgetSnippet` widget)
- Added display modes:
  - Row layout (`DisplayMode.row`)
  - Column layout (`DisplayMode.column`)
  - Tabbed layout (`DisplayMode.tabbed`)
- Terminal-style code display:
  - Custom window title
  - Brightness themes (dark/light)
  - Syntax highlighting
- Export and sharing capabilities:
  - Download widgets as images
  - Copy code snippets with feedback
  - Export both as a zip file
  - Status messages for operation feedback
- Configuration options:
  - Comprehensive `WidgetSnippetConfig` with `copyWith()` method
  - Responsive design with automatic mode selection based on available space
- Added conditional imports for web/non-web platform compatibility
- Documentation examples with region markers for documentation generation tools
