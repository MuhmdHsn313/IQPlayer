import 'package:equatable/equatable.dart';

///! The user have not to use this class.
/// This class provide the event of subtitles!
abstract class SubtitleEvent extends Equatable {
  const SubtitleEvent();

  @override
  List<Object> get props => [];
}

class FetchSubtitles extends SubtitleEvent {}

class UpdateSubtitle extends SubtitleEvent {
  final Duration position;

  const UpdateSubtitle(this.position);

  @override
  List<Object> get props => [position];

  @override
  String toString() => "Position { duration: $position }";
}
