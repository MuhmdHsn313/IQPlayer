import 'dart:async';

import '../models/subtitle.dart';

///! The user have not to use this class.
/// This decode subtitles after fetched by [SubtitleRepository].
/// The decode with [RegExp].
class SubtitleController {
  /// This method that decode the subtitles by provide a [FutureOr<String>].
  Future<List<Subtitle>> fetchList(FutureOr<String> data) async {
    RegExp regExp = new RegExp(
      r"(\d{1,2}):(\d{2}):(\d{2})\.(\d+) --> (\d{1,2}):(\d{2}):(\d{2})\.(\d+)(?:.*)(\D*)",
      caseSensitive: false,
      multiLine: true,
    );

    RegExp missHourMi = new RegExp(
      r"^(\d{1,2}):(\d{2})\.(\d+) --> (\d{1,2}):(\d{2}):(\d{2})\.(\d+)(?:.*)(\D*)",
      caseSensitive: true,
      multiLine: false,
    );

    RegExp missHour = new RegExp(
      r"(\d{1,2}):(\d{2})\.(\d+) --> (\d{2}):(\d{2})\.(\d+)(?:.*)(\D*)",
      caseSensitive: false,
      multiLine: true,
    );

    String content = await data;

    List<String> subList = content.split('\n');

    for (int i = 0; i < subList.length; i++) {
      if (missHour.hasMatch(subList[i])) {
        subList[i] = subList[i].replaceAllMapped(missHour, (m) {
          return "00:${m[1]}:${m[2]}.${m[3]} --> 00:${m[4]}:${m[5]}.${m[6]}";
        });
      } else if (missHourMi.hasMatch(subList[i])) {
        subList[i] = subList[i].replaceAllMapped(missHourMi, (m) {
          return "00:${m[1]}:${m[2]}.${m[3]} --> ${m[4]}:${m[5]}:${m[6]}.${m[7]}";
        });
      }
    }

    content = subList.join('\n');

    List<RegExpMatch> matches = regExp.allMatches(content).toList();
    List<Subtitle> subtitleList = List<Subtitle>();

    matches.forEach(
      (RegExpMatch regExpMatch) {
        int startTimeHours = int.parse(regExpMatch.group(1));
        int startTimeMinutes = int.parse(regExpMatch.group(2));
        int startTimeSeconds = int.parse(regExpMatch.group(3));
        int startTimeMilliseconds = int.parse(regExpMatch.group(4));

        int endTimeHours = int.parse(regExpMatch.group(5));
        int endTimeMinutes = int.parse(regExpMatch.group(6));
        int endTimeSeconds = int.parse(regExpMatch.group(7));
        int endTimeMilliseconds = int.parse(regExpMatch.group(8));
        String text = regExpMatch.group(9);

        Duration startTime = Duration(
            hours: startTimeHours,
            minutes: startTimeMinutes,
            seconds: startTimeSeconds,
            milliseconds: startTimeMilliseconds);
        Duration endTime = Duration(
            hours: endTimeHours,
            minutes: endTimeMinutes,
            seconds: endTimeSeconds,
            milliseconds: endTimeMilliseconds);

        subtitleList.add(
          Subtitle(
            start: startTime,
            end: endTime,
            data: text.trim(),
          ),
        );
      },
    );

    return subtitleList;
  }
}
