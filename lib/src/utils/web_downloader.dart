/// Web-specific implementation for the downloader utility.
///
/// This file contains web-specific code using dart:html for browser downloads.
/// It's separated to prevent dart:html errors in tests and non-web environments.
///
/// Note: We're using dart:html for compatibility with a broad range of browsers
/// and Flutter versions. While it's marked as deprecated in favor of package:web
/// and dart:js_interop, we'll maintain this implementation until broader adoption
/// of the newer APIs is in place.
library widget_snippet.web_downloader;

// ignore: deprecated_member_use
import 'dart:html' as html;

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';

/// Web implementation of the widget downloader.
///
/// This class handles downloading widget previews and their source code
/// as zip files specifically in web environments using browser APIs.
class WebDownloader {
  // Private constructor to prevent instantiation
  WebDownloader._();

  /// Downloads the widget preview and code as a zip file on web browsers.
  ///
  /// This method uses browser APIs to create and trigger a file download.
  /// It creates a zip file containing the widget preview image and source code,
  /// then triggers the browser's download mechanism.
  ///
  /// Parameters:
  /// * [fileName] - The base name for the downloaded file
  /// * [widgetAsBytes] - The widget preview as a PNG image in bytes
  /// * [sourceCode] - The source code of the widget as a string
  /// * [showMessage] - Callback function to display success or error messages
  static Future<void> webDownload({
    required String fileName,
    required Uint8List? widgetAsBytes,
    required String sourceCode,
    required void Function({required String message, bool isError}) showMessage,
  }) async {
    try {
      // Create a zip with both the image and code
      final Archive archive = Archive();

      // Add the image file
      if (widgetAsBytes != null) {
        const String imagePath = 'widget-preview.png';
        archive.addFile(
          ArchiveFile(imagePath, widgetAsBytes.length, widgetAsBytes),
        );
      }

      // Add the code file
      final Uint8List codeBytes = Uint8List.fromList(sourceCode.codeUnits);
      archive.addFile(
        ArchiveFile('source-code.dart', codeBytes.length, codeBytes),
      );

      // Write the zip file
      final List<int> zipBytes = ZipEncoder().encode(archive);

      // Use browser APIs to trigger download
      final html.Blob blob = html.Blob(<dynamic>[zipBytes]);
      final String url = html.Url.createObjectUrlFromBlob(blob);
      final html.AnchorElement anchor =
          html.document.createElement('a') as html.AnchorElement
            ..href = url
            ..style.display = 'none'
            ..download = '$fileName.zip';
      html.document.body?.children.add(anchor);

      // Trigger download
      anchor.click();

      // Cleanup DOM and resources
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);

      // Show success message
      showMessage(message: 'Download completed', isError: false);
    } catch (e) {
      // Log error with debugPrint for consistency
      debugPrint('Download error: $e');
      showMessage(message: 'Failed to download', isError: true);
    }
  }
}
