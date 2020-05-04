import 'package:equatable/equatable.dart';

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
