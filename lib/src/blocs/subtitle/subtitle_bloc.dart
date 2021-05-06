import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../models/subtitle.dart';
import '../../utils/subtitle_controller.dart';
import '../../utils/subtitle_provider.dart';

///! The user have not to use this class.
/// This class manage the state of subtitles!
class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  final SubtitleProvider _subtitleProvider;
  final SubtitleController _subtitleController;

  List<Subtitle> subtitles;

  SubtitleBloc(this._subtitleProvider)
      : subtitles = <Subtitle>[],
        _subtitleController = new SubtitleController(),
        super(SubtitleState.initial());

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
