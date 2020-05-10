import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/player/bloc.dart';
import 'package:iqplayer/src/blocs/screen/bloc.dart';
import 'package:iqplayer/src/utils/iqtheme.dart';

import 'iqparser.dart';

class ScreenControllers extends StatelessWidget {
  final AnimationController playAnimationController;
  final IQTheme iqTheme;

  const ScreenControllers({
    Key key,
    @required this.playAnimationController,
    @required this.iqTheme,
  })  : assert(iqTheme != null),
        assert(playAnimationController != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenBloc, ScreenState>(
      bloc: BlocProvider.of<ScreenBloc>(context),
      builder: (context, state) => GestureDetector(
        onTap: () => BlocProvider.of<ScreenBloc>(context).add(
          state.showControls ? HideControls() : ShowControls(),
        ),
        child: state.showControls && !state.lockScreen
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildAppBar(context, state),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: iqTheme.backwardIconButton ??
                              Icon(
                                Icons.replay_5,
                                color: Colors.white,
                              ),
                          onPressed: () => BlocProvider.of<PlayerBloc>(context)
                              .add(Backward()),
                        ),
                        _mainButton(context),
                        IconButton(
                          icon: iqTheme.forwardIconButton ??
                              Icon(
                                Icons.forward_10,
                                color: Colors.white,
                              ),
                          onPressed: () => BlocProvider.of<PlayerBloc>(context)
                              .add(Forward()),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IQParser(
                          iqTheme: iqTheme,
                        ),
                        _buildBottomScreen(context, state),
                      ],
                    ),
                  ],
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Container(),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            state.lockScreen ? Icons.lock : Icons.lock_open,
                            color: iqTheme.lockScreenColor,
                          ),
                          tooltip: state.lockScreen
                              ? 'Unlock Screen'
                              : 'Lock Screen',
                          onPressed: () =>
                              BlocProvider.of<ScreenBloc>(context).add(
                            state.lockScreen ? UnlockScreen() : LockScreen(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: BlocBuilder<PlayerBloc, PlayerState>(
                        bloc: BlocProvider.of<PlayerBloc>(context),
                        builder: (BuildContext context, PlayerState state) {
                          if (state is LoadingState)
                            return iqTheme.loadingProgress ??
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    iqTheme.playButtonColor ?? Colors.green,
                                  ),
                                );

                          if (state is FinishState)
                            return Container(
                              decoration: BoxDecoration(
                                color: iqTheme.playButtonColor ?? Colors.green,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: iqTheme.replayButton != null
                                    ? []
                                    : [
                                        BoxShadow(color: Colors.black45),
                                      ],
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon:
                                    iqTheme.replayButton ?? Icon(Icons.replay),
                                onPressed: () {
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(FetchVideo());
                                },
                              ),
                            );

                          return Container();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: IQParser(
                        iqTheme: iqTheme,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ScreenState state) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            BlocProvider.of<ScreenBloc>(context).title,
            style: iqTheme.titleStyle,
          ),
          Text(
            BlocProvider.of<ScreenBloc>(context).description,
            overflow: TextOverflow.fade,
            style: iqTheme.descriptionStyle ??
                TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: iqTheme.lockRotation != null
              ? iqTheme.lockRotation(state.lockRotation)
              : Icon(
                  state.lockRotation
                      ? Icons.screen_lock_rotation
                      : Icons.screen_rotation,
                  color: iqTheme.lockRotationColor,
                ),
          tooltip: state.lockRotation ? 'Unlock Rotation' : 'Lock Rotation',
          onPressed: () => BlocProvider.of<ScreenBloc>(context).add(
            state.lockRotation
                ? UnlockRotation()
                : LockRotation(MediaQuery.of(context).orientation),
          ),
        ),
        IconButton(
          icon: iqTheme.lockScreen != null
              ? iqTheme.lockScreen(state.lockScreen)
              : Icon(
                  state.lockScreen ? Icons.lock : Icons.lock_open,
                  color: iqTheme.lockScreenColor,
                ),
          tooltip: state.lockScreen ? 'Unlock Screen' : 'Lock Screen',
          onPressed: () => BlocProvider.of<ScreenBloc>(context).add(
            state.lockScreen ? UnlockScreen() : LockScreen(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomScreen(BuildContext context, ScreenState state) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      bloc: BlocProvider.of<PlayerBloc>(context),
      builder: (context, state) {
        if (state is PlayingState)
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  _formatDuration(state.position),
                  style:
                      iqTheme.durationStyle ?? TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    value: state.position.inSeconds.toDouble(),
                    min: Duration.zero.inSeconds.toDouble(),
                    max: state.duration.inSeconds.toDouble(),
                    activeColor: iqTheme.videoPlayedColor ?? Colors.green,
                    inactiveColor:
                        iqTheme.backgroundProgressColor ?? Colors.green[200],
                    onChanged: (value) =>
                        BlocProvider.of<PlayerBloc>(context).add(
                      ChangeTimeTo(
                        Duration(seconds: value.toInt()),
                      ),
                    ),
                  ),
                ),
                Text(
                  _formatDuration(state.duration),
                  style:
                      iqTheme.durationStyle ?? TextStyle(color: Colors.white),
                ),
              ],
            ),
          );

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                _formatDuration(Duration.zero),
                style: iqTheme.durationStyle ?? TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: Duration.zero.inSeconds.toDouble(),
                  min: Duration.zero.inSeconds.toDouble(),
                  max: Duration.zero.inSeconds.toDouble(),
                  activeColor: iqTheme.videoPlayedColor ?? Colors.green,
                  inactiveColor:
                      iqTheme.backgroundProgressColor ?? Colors.green[200],
                  onChanged: (double value) {},
                ),
              ),
              Text(
                _formatDuration(Duration.zero),
                style: iqTheme.durationStyle ?? TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mainButton(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      bloc: BlocProvider.of<PlayerBloc>(context),
      builder: (BuildContext context, PlayerState state) {
        if (state is PlayingState)
          return Container(
            decoration: BoxDecoration(
              color: iqTheme.playButtonColor ?? Colors.green,
              borderRadius: BorderRadius.circular(50),
              boxShadow: iqTheme.playButton != null
                  ? []
                  : [
                      BoxShadow(color: Colors.black45),
                    ],
            ),
            child: IconButton(
              color: Colors.white,
              icon: state is FinishState
                  ? iqTheme.replayButton ?? Icon(Icons.replay)
                  : iqTheme.playButton != null
                      ? iqTheme.playButton(state.isPlay)
                      : AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          progress: Tween<double>(begin: 0.0, end: 1.0).animate(
                            playAnimationController,
                          ),
                        ),
              onPressed: () {
                if (state is FinishState) {
                  print('FetchVideo');
                  BlocProvider.of<PlayerBloc>(context).add(FetchVideo());
                  return;
                }
                print(state.isPlay);
                if (!state.isPlay) {
                  print('PlayVideo');
                  BlocProvider.of<PlayerBloc>(context).add(PlayVideo());
                  playAnimationController.reverse();
                  return;
                }
                if (state.isPlay) {
                  print('PauseVideo');
                  BlocProvider.of<PlayerBloc>(context).add(PauseVideo());
                  playAnimationController.forward();
                  return;
                }
              },
            ),
          );

        if (state is ErrorState)
          return iqTheme.errorWidget ??
              Row(
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  Text('${state.error}'),
                ],
              );

        return iqTheme.loadingProgress ??
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                iqTheme.loadingProgressColor ?? Colors.green,
              ),
            );
      },
    );
  }

  String _formatDuration(Duration position) {
    final ms = position?.inMilliseconds ?? 0;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10 ? '$hours' : hours == 0 ? '00' : '0$hours';

    final minutesString =
        minutes >= 10 ? '$minutes' : minutes == 0 ? '00' : '0$minutes';

    final secondsString =
        seconds >= 10 ? '$seconds' : seconds == 0 ? '00' : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : hoursString + ':'}$minutesString:$secondsString';

    return formattedTime;
  }
}
