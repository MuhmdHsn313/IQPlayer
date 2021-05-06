import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

///! The user have not to use this class.
/// Created to load the subtitles as a string from with value need to use futrue.
class SubtitleRepository {
  /// Load the subtitles from network by provide the file url.
  Future<String> fetchFromNetwork(String url) async {
    final response = await get(Uri.http(url, ''));
    if (response.statusCode == 200) return utf8.decode(response.bodyBytes);
    throw 'ERROR_FETCH_SUBTITLE(${response.statusCode})';
  }

  /// Load the subtitles from specific file.
  Future<String> fetchFromFile(File file) {
    return file.readAsString();
  }

  /// Load the subtitles from specific file in assets.
  Future<String> fetchFromAssets(String path) async {
    return rootBundle.loadString(path);
  }
}
