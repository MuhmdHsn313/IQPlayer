import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///! The user have not to use this class.
/// This class provide the state of player not the ui!
abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class LoadingState extends PlayerState {}

class PlayingState extends PlayerState {
  final bool isPlay;
  final Duration duration;
  final Duration position;

  const PlayingState({
    @required this.isPlay,
    @required this.duration,
    @required this.position,
  })  : assert(isPlay != null),
        assert(position != null);

  @override
  List<Object> get props => [isPlay, position, duration];
}

class FinishState extends PlayerState {}

class ErrorState extends PlayerState {
  final dynamic error;

  const ErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "ErrorState { error: $error }";
}
