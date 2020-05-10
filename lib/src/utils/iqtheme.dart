import 'package:flutter/widgets.dart';
import 'package:iqplayer/src/utils/public_type.dart';

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
  final Widget playButton;
  final Widget replayButton;
  final Widget loadingProgress;

  final IQErrorBuilder errorWidget;

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
  });
}
