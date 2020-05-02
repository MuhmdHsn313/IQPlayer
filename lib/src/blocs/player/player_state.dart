import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class LoadingState extends PlayerState {}

class PlayingState extends PlayerState {
  final Duration duration;
  final Duration position;

  const PlayingState({
    @required this.duration,
    @required this.position,
  })  : assert(duration != null),
        assert(duration != null);
}

class ErrorState extends PlayerState {
  final dynamic error;

  const ErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "ErrorState { error: $error }";
}
