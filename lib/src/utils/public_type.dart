import 'package:flutter/widgets.dart';

/// This is provide a method you can use to make your customization.

/// Call when handle error.
typedef IQErrorBuilder = Widget Function(BuildContext context, dynamic error);

/// Call when [playButton] build.
typedef IQPlayButtonBuilder = Widget Function(
    BuildContext context, bool isPlay, AnimationController animationController);

/// Call when [lockButton] build.
typedef IQLockButtonBuilder = Widget Function(
    BuildContext context, bool isLock, AnimationController animationController);
