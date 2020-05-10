import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:iqplayer/iqplayer.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final VideoPlayerController controller;

  VideoPlayerValue value;

  PlayerBloc(this.controller);

  @override
  PlayerState get initialState {
    controller.addListener(_listener);
    return LoadingState();
  }

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is FetchVideo) {
      yield LoadingState();
      value = controller.value;
      if (value.initialized) {
        await controller.initialize();
        add(PlayVideo());
      } else if (value.hasError) {
        controller.initialize();
        add(PlayVideo());
      } else if (value.buffered.isNotEmpty) {
        if (value.buffered.last.end == value.duration) {
          controller.seekTo(Duration.zero);
          add(PlayVideo());
        }
      }
    }

    if (event is PlayVideo) {
      if (value != null) if (!value.isPlaying) await controller.play();
      yield PlayingState(
        isPlay: value.isPlaying,
        duration: value?.duration ?? Duration.zero,
        position: value?.position ?? Duration.zero,
      );
    }
    if (event is PauseVideo) {
      if (value.isPlaying) await controller.pause();
      yield PlayingState(
        isPlay: value.isPlaying,
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is Forward) {
      Duration newPosition = value.position + Duration(seconds: 10);
      await controller.seekTo(newPosition);
      yield PlayingState(
        isPlay: value.isPlaying,
        duration: value.duration,
        position: newPosition,
      );
    }
    if (event is Backward) {
      Duration newPosition = value.position - Duration(seconds: 5);
      await controller.seekTo(newPosition);
      yield PlayingState(
        isPlay: value.isPlaying,
        duration: value.duration,
        position: newPosition,
      );
    }
    if (event is ChangeTimeTo) {
      await controller.seekTo(event.duration);
      yield PlayingState(
        isPlay: value.isPlaying,
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is FinishVideo) {
      yield FinishState(
        position: event.position,
        duration: event.duration,
      );
    }
    if (event is HandleError) yield ErrorState(event.error);
  }

  void _listener() {
    value = controller.value;
    if (value.buffered != null && value.buffered.isNotEmpty) if (value
            .buffered.last.end ==
        value.duration) {
      add(
        FinishVideo(
          position: value.position,
          duration: value.duration,
        ),
      );
      return;
    }
    if (value.buffered.isNotEmpty) {
      if (value.buffered.last.end == value.position) {
        add(FetchVideo());
        return;
      }
    }
    if (value.initialized && value.isPlaying) {
      add(PlayVideo());
      return;
    }
  }

  @override
  Future<void> close() {
    controller.removeListener(_listener);
    return super.close();
  }
}
