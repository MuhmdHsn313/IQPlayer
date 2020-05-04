import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

class SubtitleRepository {
  Future<String> fetchFromNetwork(String url) async {
    final response = await get(url);
    if (response.statusCode == 200) return utf8.decode(response.bodyBytes);
    throw 'ERROR_FETCH_SUBTITLE(${response.statusCode})';
  }

  Future<String> fetchFromFile(File file) async {
    final data = await file.readAsString();
    return utf8.decode(data.codeUnits);
  }

  Future<String> fetchFromAssets(String path) async {
    final String data = await rootBundle.loadString(path);
    return utf8.decode(data.codeUnits);
  }
}
