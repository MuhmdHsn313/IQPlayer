import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:iqplayer/iqplayer.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final VideoPlayerController controller;

  VideoPlayerValue value;

  PlayerBloc(this.controller);

  @override
  PlayerState get initialState => LoadingState();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is FetchVideo) {
      yield LoadingState();
      await controller.initialize();
      controller.addListener(() {
        value = controller.value;

        if (value.hasError)
          add(HandleError(value.errorDescription));
        else if (value.initialized)
          add(PlayVideo());
        else
          add(FetchVideo());
      });
    }

    if (event is PlayVideo) {
      controller.play();
      yield PlayingState(
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is PauseVideo) {
      controller.pause();
      yield PlayingState(
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is Forward) {
      controller.seekTo(value.duration + Duration(seconds: 10));
      yield PlayingState(
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is Backward) {
      controller.seekTo(value.duration - Duration(seconds: 5));
      yield PlayingState(
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is ChangeTimeTo) {
      controller.seekTo(event.duration);
      yield PlayingState(
        duration: value.duration,
        position: value.position,
      );
    }
    if (event is HandleError) yield ErrorState(event.error);
  }
}
