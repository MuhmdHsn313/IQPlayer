import 'package:flutter/widgets.dart';

import 'public_type.dart';

/// This class contorl theme of player, give this class the
/// value you need to change, else you can let it null!
class IQTheme {
  final Color loadingProgressColor;
  final Color playButtonColor;
  final Color backgroundProgressColor;
  final Color videoPlayedColor;
  final Color lockScreenColor;
  final Color lockRotationColor;

  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final TextStyle subtitleStyle;
  final TextStyle durationStyle;

  final Widget forwardIconButton;
  final Widget backwardIconButton;
  final Widget replayButton;
  final Widget loadingProgress;

  final IQErrorBuilder errorWidget;
  final IQPlayButtonBuilder playButton;
  final IQLockButtonBuilder lockScreen;
  final IQLockButtonBuilder lockRotation;

  const IQTheme({
    this.loadingProgressColor,
    this.playButtonColor,
    this.backgroundProgressColor,
    this.videoPlayedColor,
    this.lockScreenColor,
    this.lockRotationColor,
    this.titleStyle,
    this.descriptionStyle,
    this.subtitleStyle,
    this.durationStyle,
    this.forwardIconButton,
    this.backwardIconButton,
    this.playButton,
    this.replayButton,
    this.errorWidget,
    this.loadingProgress,
    this.lockScreen,
    this.lockRotation,
  });
}
