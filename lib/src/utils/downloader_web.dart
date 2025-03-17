/// Web entrypoint for the downloader utility.
///
/// This file is used for conditional imports in Flutter to provide web-specific
/// implementation when running in a browser environment. It delegates to the
/// WebDownloader class which contains the actual web-specific download logic.
library widget_snippet.downloader_web;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'web_downloader.dart';

// This conditional export is crucial for platform-specific handling
export 'downloader.dart' if (dart.library.html) 'downloader_web.dart';

/// Web-specific implementation of the Downloader class.
///
/// This class mirrors the API of the non-web Downloader class but delegates
/// to WebDownloader for actual implementation, enabling conditional imports.
class Downloader {
  // Private constructor to prevent instantiation
  Downloader._();

  /// Downloads the widget preview and code as a zip file in web environments.
  ///
  /// This method delegates to WebDownloader.webDownload for the actual implementation.
  /// It ensures the API matches the non-web Downloader class for seamless conditional imports.
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
      await WebDownloader.webDownload(
        fileName: fileName,
        widgetAsBytes: widgetAsBytes,
        sourceCode: sourceCode,
        showMessage: showMessage,
      );
    } else {
      // This should never happen when using web entrypoint,
      // as conditional imports should have selected the correct implementation
      showMessage(message: 'Platform not supported', isError: true);
    }
  }
}
