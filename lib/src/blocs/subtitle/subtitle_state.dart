import 'package:equatable/equatable.dart';

import '../../models/subtitle.dart';

///! The user have not to use this class.
/// This class provide the state of subtitles!
class SubtitleState extends Equatable {
  final String data;

  const SubtitleState(this.data);

  factory SubtitleState.initial() => SubtitleState('');

  SubtitleState copyWith(Subtitle subtitle) =>
      SubtitleState(subtitle.data ?? this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => "SubtitleState { date: $data }";
}
