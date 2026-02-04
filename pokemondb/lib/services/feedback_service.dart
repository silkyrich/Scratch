import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class FeedbackService {
  static const _imgurClientId = '546c25a59c58ad7';
  static const _githubRepo = 'silkyrich/pokedex-flutter';

  /// Captures a screenshot from a RepaintBoundary identified by the given key.
  static Future<Uint8List?> captureScreenshot(GlobalKey boundaryKey) async {
    try {
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  /// Uploads a PNG image to Imgur anonymously. Returns the image URL or null.
  static Future<String?> uploadToImgur(Uint8List imageBytes) async {
    try {
      final base64Image = base64Encode(imageBytes);
      final response = await http.post(
        Uri.parse('https://api.imgur.com/3/image'),
        headers: {'Authorization': 'Client-ID $_imgurClientId'},
        body: {'image': base64Image, 'type': 'base64'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['link'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Opens a pre-filled GitHub Issue with the feedback text and optional screenshot URL.
  static Future<void> submitFeedback({
    required String title,
    required String description,
    String? screenshotUrl,
    String? currentRoute,
  }) async {
    final buffer = StringBuffer();

    buffer.writeln('## Feedback');
    buffer.writeln();
    buffer.writeln(description);
    buffer.writeln();

    if (currentRoute != null) {
      buffer.writeln('**Page:** `$currentRoute`');
      buffer.writeln();
    }

    if (screenshotUrl != null) {
      buffer.writeln('## Screenshot');
      buffer.writeln('![Screenshot]($screenshotUrl)');
      buffer.writeln();
    }

    buffer.writeln('---');
    buffer.writeln('*Submitted via in-app feedback*');

    final uri = Uri.https('github.com', '/$_githubRepo/issues/new', {
      'title': title,
      'body': buffer.toString(),
      'labels': 'feedback',
    });

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
