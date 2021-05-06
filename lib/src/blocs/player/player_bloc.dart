import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../iqplayer.dart';

part 'player_event.dart';
part 'player_state.dart';

///! The user have not to use this class.
/// This class manage the state of player not the ui!
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final VideoPlayerController controller;

  PlayerBloc(this.controller) : super(LoadingState()) {
    controller.addListener(_listener);
  }

  VideoPlayerValue? value;

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is FetchData) {
      yield LoadingState();
      if (value != null) {
        controller.initialize();
      }
      add(PlayVideo());
    }

    if (event is UpdateData) {
      if (value!.duration == value!.position)
        yield FinishState();
      else if (event.loading) {
        yield LoadingState();
      } else
        yield PlayingState(
          isPlay: value!.isPlaying,
          duration: value!.duration,
          position: value!.position,
        );
    }

    if (event is PlayVideo) {
      controller.play();
      yield PlayingState(
        isPlay: true,
        duration: value!.duration,
        position: value!.position,
      );
    }

    if (event is PauseVideo) {
      controller.pause();
      yield PlayingState(
        isPlay: false,
        duration: value!.duration,
        position: value!.position,
      );
    }
    if (event is Forward) {
      Duration newPosition = value!.position + event.duration;
      if (value!.duration > newPosition) {
        controller.seekTo(newPosition);
        yield PlayingState(
          isPlay: value!.isPlaying,
          duration: value!.duration,
          position: newPosition,
        );
      }
    }
    if (event is Backward) {
      Duration newPosition = value!.position - event.duration;
      if (value!.position > Duration(seconds: 6)) {
        controller.seekTo(newPosition);
        yield PlayingState(
          isPlay: value!.isPlaying,
          duration: value!.duration,
          position: newPosition,
        );
      }
    }
    if (event is ChangeTimeTo) {
      if (event.duration >= Duration.zero &&
          event.duration <= value!.duration) {
        controller.seekTo(event.duration);
        yield PlayingState(
          isPlay: value!.isPlaying,
          duration: value!.duration,
          position: value!.position,
        );
      }
    }

    if (event is ReplayVideo) {
      controller.seekTo(Duration.zero).then((value) => controller.play());
      yield PlayingState(
        isPlay: true,
        duration: value!.duration,
        position: value!.position,
      );
    }
  }

  void _listener() {
    value = controller.value;
    DurationRange buffer = DurationRange(Duration.zero, Duration.zero);

    if (value!.buffered.isNotEmpty) buffer = value!.buffered.last;

    if (buffer.end == value!.position && value!.position != value!.duration)
      return add(UpdateData(value!.position, value!.duration, true));

    return add(UpdateData(
      value!.position,
      value!.duration,
    ));
  }

  @override
  Future<void> close() {
    controller.removeListener(_listener);
    return super.close();
  }
}
