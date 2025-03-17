import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/downloader.dart'
    if (dart.library.html) '../utils/downloader_web.dart';

/// A button that allows users to download the widget preview and code as a zip file.
class DownloadZipButton extends StatefulWidget {
  /// Constructor for the DownloadZipButton widget.
  const DownloadZipButton({
    super.key,
    required this.screenshotController,
    required this.sourceCode,
    required this.title,
  });

  /// Controller for taking screenshots of the widget.
  final ScreenshotController screenshotController;

  /// The source code of the widget.
  final String sourceCode;

  /// The title of the widget, used for the zip file name.
  final String title;

  @override
  State<DownloadZipButton> createState() => _DownloadZipButtonState();
}

class _DownloadZipButtonState extends State<DownloadZipButton> {
  /// The message to display to the user after a download attempt.
  String message = '';

  /// The color of the message container (green for success, red for error).
  Color baseColor = Colors.green;

  /// Displays a temporary message to the user with appropriate styling.
  ///
  /// The message disappears after a short delay.
  ///
  /// Parameters:
  /// * [message] - The message to display
  /// * [isError] - Whether the message is an error message
  void _showMessage({required String message, bool isError = false}) {
    setState(() {
      this.message = message;
      baseColor = isError ? Colors.red : Colors.green;
    });

    Future<void>.delayed(const Duration(seconds: 2), () {
      setState(() {
        this.message = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        IconButton(
          tooltip: 'Download Widget Preview and Code Snippet',
          icon: const Icon(Icons.archive),
          onPressed: () => _downloadWidget(context),
        ),
      ],
    );
  }

  /// Captures a screenshot of the widget and downloads it along with the source code as a ZIP file.
  ///
  /// This method uses the screenshot controller to capture the widget as an image,
  /// then packages it with the source code into a ZIP file that can be downloaded.
  ///
  /// The download process and any resulting success/error messages are handled through
  /// the Downloader utility.
  Future<void> _downloadWidget(BuildContext context) async {
    final Uint8List? bytes = await widget.screenshotController.capture();
    Downloader.downloadZipFile(
      fileName: widget.title,
      widgetAsBytes: bytes,
      sourceCode: widget.sourceCode,
      showMessage: _showMessage,
    );
  }
}
