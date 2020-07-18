import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///! The user have not to use this class.
/// This class provide the event of ui not the player!
abstract class ScreenEvent extends Equatable {
  const ScreenEvent();

  @override
  List<Object> get props => [];
}

class ShowControls extends ScreenEvent {}

class HideControls extends ScreenEvent {}

class LockRotation extends ScreenEvent {
  final Orientation orientation;

  const LockRotation(this.orientation);

  @override
  List<Object> get props => [orientation];
}

class UnlockRotation extends ScreenEvent {}

class LockScreen extends ScreenEvent {}

class UnlockScreen extends ScreenEvent {}
