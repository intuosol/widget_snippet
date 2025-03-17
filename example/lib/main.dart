import 'package:flutter/material.dart';
import 'package:intuosol_design_system/intuosol_design_system.dart';
import 'package:widget_snippet/widget_snippet.dart';
import 'package:widget_snippet_example/example_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return IntuoSolApp(
      home: const WidgetSnippetDemo(),
      themeMode: ThemeMode.light,
    );
  }
}

class WidgetSnippetDemo extends StatelessWidget {
  const WidgetSnippetDemo({super.key});

  static final Widget myCustomWidget = ExampleWidget();

  String get sourceCode => ExampleWidget().sourceCode();

  @override
  Widget build(BuildContext context) {
    return IntuoSolScaffold(
      appBar: AppBar(
        title: const Text('Widget Snippet Demo'),
        actions: [ThemeModeButton()],
      ),
      body: _buildBody(context),
      drawer: _buildDrawer(context),
      floatingActionButton: IntuoSolButtons.floatingAboutPackage(
        context: context,
        packageName: 'widget_snippet',
        description:
            'A Flutter package that enables developers to easily showcase and share code snippets of their widgets.',
      ),
    );
  }

  /// Build the body of the scaffold
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSection(
              title: 'Widget Preview',
              content: WidgetSnippet(widget: myCustomWidget),
            ),

            _buildSection(
              title: 'Code View',
              content: WidgetSnippet(sourceCode: sourceCode),
            ),

            _buildSection(
              title: 'Code View (Terminal)',
              content: WidgetSnippet(
                sourceCode: sourceCode,
                config: WidgetSnippetConfig(terminalStyle: TerminalStyle()),
              ),
            ),

            _buildSection(
              title: 'Row',
              content: WidgetSnippet(
                widget: myCustomWidget,
                sourceCode: sourceCode,
                config: WidgetSnippetConfig(displayMode: DisplayMode.row),
              ),
            ),

            _buildSection(
              title: 'Column',
              content: WidgetSnippet(
                widget: myCustomWidget,
                sourceCode: sourceCode,
                config: WidgetSnippetConfig(displayMode: DisplayMode.column),
              ),
            ),

            _buildSection(
              title: 'Tabbed',
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: WidgetSnippet(
                  widget: myCustomWidget,
                  sourceCode: sourceCode,
                  config: WidgetSnippetConfig(displayMode: DisplayMode.tabbed),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a section with a title and content
  Widget _buildSection({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IntuoSolSectionHeader(title: title),
        content,
        const SizedBox(height: 32),
      ],
    );
  }

  /// Build the drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        spacing: 16,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  'Widget Snippet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IntuoSolLogos.byIntuoSolText(
                    context: context,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8.0,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text('Show Full Screen'),
                  onTap:
                      () => WidgetSnippet.showFullScreen(
                        context: context,
                        widget: myCustomWidget,
                        sourceCode: sourceCode,
                      ),
                ),
                ListTile(
                  title: const Text('Show Bottom Sheet'),
                  onTap:
                      () => WidgetSnippet.showBottomSheet(
                        context: context,
                        widget: myCustomWidget,
                        sourceCode: sourceCode,
                      ),
                ),
                ListTile(
                  title: const Text('Show Popup Dialog'),
                  onTap:
                      () => WidgetSnippet.showPopup(
                        context: context,
                        widget: myCustomWidget,
                        sourceCode: sourceCode,
                      ),
                ),
                ListTile(
                  title: const Text('Show Modal'),
                  subtitle: const Text(
                    'Displays a bottom sheet for small screens and a popup dialog for larger screens.',
                  ),
                  onTap:
                      () => WidgetSnippet.showModal(
                        context: context,
                        widget: myCustomWidget,
                        sourceCode: sourceCode,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
