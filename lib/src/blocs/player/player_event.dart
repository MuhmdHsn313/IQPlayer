import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class FetchVideo extends PlayerEvent {}

class PlayVideo extends PlayerEvent {}

class PauseVideo extends PlayerEvent {}

class Forward extends PlayerEvent {}

class Backward extends PlayerEvent {}

class HandleError extends PlayerEvent {
  final dynamic error;

  const HandleError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "HandleError { error: $error }";
}

class ChangeTimeTo extends PlayerEvent {
  final Duration duration;

  const ChangeTimeTo(this.duration);

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "ChangeTimeTo { duration: $duration }";
}
