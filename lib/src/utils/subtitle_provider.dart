library iqplayer.util;

import 'dart:async';
import 'dart:io';

import '../repositories/subtitle_repository.dart';

/// Use it for provide the subtitle from:
class SubtitleProvider {
  final FutureOr<String> data;

  const SubtitleProvider._(this.data);

  /// Network: use [SubtitleProvider.fromNetwork()] and give it a url, for example:
  ///   ```dart
  ///     IQScreen(
  ///       subtitleProvider: SubtitleProvider.fromNetwork(
  ///         'https://duoidi6ujfbv.cloudfront.net/media/0/subtitles/5675420c9d9a3.vtt',
  ///       ),
  ///       ...
  ///     ),
  ///   ```
  ///
  factory SubtitleProvider.fromNetwork(String url) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromNetwork(url),
    );
  }

  /// File: use it [SubtitleProvider.fromFile()] by provide the file to load subtitles, for example:
  ///   ```dart
  ///     File subtitle = new File('<Your File Path>')
  ///     IQScreen(
  ///       subtitleProvider: SubtitleProvider.fromFile(subtitle),
  ///       ...
  ///     ),
  ///   ```
  factory SubtitleProvider.fromFile(File file) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromFile(file),
    );
  }

  /// Assets: use it [SubtitleProvider.fromAssets()] to provide the assets file, for example:
  ///   ```dart
  ///     IQScreen(
  ///       subtitleProvider: SubtitleProvider.fromAssets('<Your Assets File Path>'),
  ///       ...
  ///     ),
  ///   ```
  factory SubtitleProvider.fromAssets(String path) {
    final SubtitleRepository _repository = SubtitleRepository();
    return SubtitleProvider._(
      _repository.fetchFromAssets(path),
    );
  }

  /// String: use it to provide a string for generate a subtitles, for example:
  ///   ```dart
  ///   IQScreen(
  ///     subtitleProvider: SubtitleProvider.fromString(
  ///         """WEBVTT
  ///
  ///            00:00:00.650 --> 00:00:03.000
  ///            <p style="color:blue">Hello World</p>
  ///
  ///           00:00:03.024 --> 00:00:07.524
  ///           <i>Mindmarker je krátká zpráva formou
  ///           videa, souborů PDF...</i>
  ///
  ///           00:00:07.548 --> 00:00:12.448
  ///           <span style='color:brown'>colorful</span>
  ///
  ///           00:00:12.472 --> 00:00:16.072
  ///           Mindmarker budeš obdržovat
  ///           ve specifický chvílích...
  ///
  ///           00:00:16.100 --> 00:00:20.100
  ///           abychom lépe utužili tvé znalosti.""",
  ///     ),
  ///    ...
  ///   ),
  ///   ```
  factory SubtitleProvider.fromString(String data) => SubtitleProvider._(data);
}
