import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:iqplayer/src/models/subtitle.dart';
import 'package:iqplayer/src/utils/subtitle_provider.dart';
import 'package:iqplayer/src/utils/subtitle_controller.dart';
import './bloc.dart';

class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  final SubtitleProvider _subtitleProvider;
  final SubtitleController _subtitleController;

  List<Subtitle> subtitles;

  SubtitleBloc(this._subtitleProvider)
      : subtitles = new List<Subtitle>(),
        _subtitleController = new SubtitleController();

  @override
  SubtitleState get initialState => SubtitleState.initial();

  @override
  Stream<SubtitleState> mapEventToState(
    SubtitleEvent event,
  ) async* {
    if (event is FetchSubtitles) {
      subtitles = await _subtitleController.fetchList(_subtitleProvider.data);
    }

    if (event is UpdateSubtitle) {
      for (Subtitle subtitle in subtitles) {
        if (event.position >= subtitle.start &&
            event.position <= subtitle.end) {
          yield SubtitleState(subtitle.data);
          break;
        } else {
          yield SubtitleState.initial();
        }
      }
    }
  }
}
