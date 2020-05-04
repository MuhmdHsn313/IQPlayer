import 'dart:async';
import 'dart:io';

import 'package:iqplayer/src/repositories/subtitle_repository.dart';

class SubtitleProvider {
  final FutureOr<String> data;

  const SubtitleProvider._(this.data)
      : assert(data != null, 'Error, data received as null!');

  factory SubtitleProvider.fromNetwork(String url) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromNetwork(url),
    );
  }

  factory SubtitleProvider.fromFile(File file) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromFile(file),
    );
  }

  factory SubtitleProvider.fromAssets(String path) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromAssets(path),
    );
  }

  factory SubtitleProvider.fromString(String data) => SubtitleProvider._(data);
}
