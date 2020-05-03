import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  final String title;
  final String description;

  ScreenBloc({
    @required this.title,
    @required this.description,
  });

  @override
  ScreenState get initialState {
    _hideStateBar();
    return ScreenState.showControls();
  }

  @override
  Stream<ScreenState> mapEventToState(
    ScreenEvent event,
  ) async* {
    if (event is ShowControls) {
      yield state.copyWith(showControls: true);
    }
    if (event is HideControls) {
      yield state.copyWith(showControls: false);
    }
    if (event is LockRotation) {
      _selectRotation(event.orientation);
      yield state.copyWith(lockRotation: true);
    }
    if (event is UnlockRotation) {
      _enableRotation();
      yield state.copyWith(lockRotation: false);
    }
    if (event is LockScreen) {
      yield state.copyWith(lockScreen: true);
    }
    if (event is UnlockScreen) {
      yield state.copyWith(lockScreen: false);
    }
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _selectRotation(Orientation orientation) {
    if (orientation == Orientation.portrait)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    else
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
  }

  void _hideStateBar() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _showStateBar() async {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Future<void> close() {
    _showStateBar();
    _enableRotation();
    return super.close();
  }
}
