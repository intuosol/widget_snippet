/// Non-web implementation of the downloader utility.
///
/// This file is used in non-web environments or during testing.
/// It provides a native implementation for downloading widget previews and code
/// as a zip file on platforms like iOS, Android, Windows, macOS, and Linux.
library widget_snippet.downloader;

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Utility for downloading widget previews and code snippets.
///
/// This class handles downloading widget previews and their source code
/// as zip files in non-web environments. For web environments, a separate
/// implementation is used through conditional imports.
@pragma('vm:entry-point')
class Downloader {
  // Private constructor to prevent instantiation
  Downloader._();

  /// Downloads the widget preview and code as a zip file.
  ///
  /// This method determines the platform and uses the appropriate download method.
  /// For web platforms (during testing), it shows a success message without actual download.
  /// For native platforms, it saves the zip file to the downloads or temporary directory.
  ///
  /// Parameters:
  /// * [fileName] - The base name for the downloaded file
  /// * [widgetAsBytes] - The widget preview as a PNG image in bytes
  /// * [sourceCode] - The source code of the widget as a string
  /// * [showMessage] - Callback function to display success or error messages
  static Future<void> downloadZipFile({
    required String fileName,
    required Uint8List? widgetAsBytes,
    required String sourceCode,
    required void Function({required String message, bool isError}) showMessage,
  }) async {
    if (kIsWeb) {
      // Since we can't load dart:html in test environment,
      // we'll just show a message
      showMessage(message: 'Download completed', isError: false);
    } else {
      await _appDownload(
        fileName: fileName,
        widgetAsBytes: widgetAsBytes,
        sourceCode: sourceCode,
        showMessage: showMessage,
      );
    }
  }

  /// Downloads the widget preview and code as a zip file on native platforms.
  ///
  /// This method creates a zip file containing the widget preview image and
  /// source code file, then saves it to the device's downloads or temporary directory.
  static Future<void> _appDownload({
    required String fileName,
    required Uint8List? widgetAsBytes,
    required String sourceCode,
    required void Function({required String message, bool isError}) showMessage,
  }) async {
    try {
      if (!kIsWeb) {
        final Directory directory =
            await getDownloadsDirectory() ?? await getTemporaryDirectory();

        if (widgetAsBytes == null) {
          showMessage(message: 'Failed to download', isError: true);
          return;
        }

        // Create a zip with both the image and code
        final Archive archive = Archive();

        // Add the image file
        const String imagePath = 'widget-preview.png';
        archive.addFile(
          ArchiveFile(imagePath, widgetAsBytes.length, widgetAsBytes),
        );

        // Add the code file
        final Uint8List codeBytes = Uint8List.fromList(sourceCode.codeUnits);
        archive.addFile(
          ArchiveFile('source-code.dart', codeBytes.length, codeBytes),
        );

        // Write the zip file
        final String zipPath = '${directory.path}/$fileName.zip';
        final List<int> zipBytes = ZipEncoder().encode(archive);

        final File zipFile = File(zipPath);
        await zipFile.writeAsBytes(zipBytes);

        // Show success message
        showMessage(message: 'Download completed', isError: false);
      }
    } catch (e) {
      debugPrint(e.toString());
      showMessage(message: 'Failed to download', isError: true);
    }
  }
}
