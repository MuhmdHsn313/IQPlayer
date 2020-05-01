import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ScreenState extends Equatable {
  final bool lockScreen;
  final bool showControls;
  final bool lockRotation;

  const ScreenState({
    @required this.lockScreen,
    @required this.showControls,
    @required this.lockRotation,
  })  : assert(lockScreen != null),
        assert(showControls != null),
        assert(lockRotation != null);

  factory ScreenState.showControls({
    bool lockScreen,
    bool lockRotation,
  }) {
    return ScreenState(
      lockScreen: lockScreen ?? false,
      showControls: true,
      lockRotation: lockRotation ?? false,
    );
  }

  ScreenState copyWith({
    bool lockScreen,
    bool lockRotation,
    bool showControls,
  }) {
    return ScreenState(
      lockScreen: lockScreen ?? this.lockScreen,
      showControls: showControls ?? this.showControls,
      lockRotation: lockRotation ?? this.lockRotation,
    );
  }

  @override
  List<Object> get props => [lockScreen, showControls, lockRotation];
}
