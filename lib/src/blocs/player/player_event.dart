part of 'player_bloc.dart';

///! The user have not to use this class.
/// This class provide the event of player not the ui!
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends PlayerEvent {}

class UpdateData extends PlayerEvent {
  final Duration position;
  final Duration duration;
  final bool loading;

  const UpdateData(this.position, this.duration, [this.loading = false]);

  @override
  List<Object> get props => [position, duration, loading];

  @override
  String toString() =>
      "position: $position, duration: $duration, loading: $loading";
}

class PlayVideo extends PlayerEvent {}

class PauseVideo extends PlayerEvent {}

class ReplayVideo extends PlayerEvent {}

class ChangeTimeTo extends PlayerEvent {
  final Duration duration;

  const ChangeTimeTo(this.duration);

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "ChangeTimeTo { duration: $duration }";
}

class Forward extends ChangeTimeTo {
  const Forward([
    Duration duration = const Duration(seconds: 10),
  ]) : super(duration);
  @override
  String toString() => "Forward { duration: $duration }";
}

class Backward extends ChangeTimeTo {
  const Backward([
    Duration duration = const Duration(seconds: 5),
  ]) : super(duration);
  @override
  String toString() => "Backward { duration: $duration }";
}
