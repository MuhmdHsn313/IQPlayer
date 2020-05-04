import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/player/bloc.dart';
import 'package:iqplayer/src/blocs/screen/bloc.dart';

import 'iqparser.dart';

class ScreenControllers extends StatelessWidget {
  final AnimationController playAnimationController;

  const ScreenControllers({
    Key key,
    @required this.playAnimationController,
  })  : assert(playAnimationController != null),
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
                          icon: Icon(
                            Icons.replay_5,
                            color: Colors.white,
                          ),
                          onPressed: () => BlocProvider.of<PlayerBloc>(context)
                              .add(Backward()),
                        ),
                        _mainButton(context),
                        IconButton(
                          icon: Icon(
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
                        IQParser(),
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
                              state.lockScreen ? Icons.lock : Icons.lock_open),
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
                            return CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            );

                          if (state is FinishState)
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(color: Colors.black45),
                                ],
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.replay),
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
                      child: IQParser(),
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
          ),
          Text(
            BlocProvider.of<ScreenBloc>(context).description,
            overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(state.lockRotation
              ? Icons.screen_lock_rotation
              : Icons.screen_rotation),
          tooltip: state.lockRotation ? 'Unlock Rotation' : 'Lock Rotation',
          onPressed: () => BlocProvider.of<ScreenBloc>(context).add(
            state.lockRotation
                ? UnlockRotation()
                : LockRotation(MediaQuery.of(context).orientation),
          ),
        ),
        IconButton(
          icon: Icon(state.lockScreen ? Icons.lock : Icons.lock_open),
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
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    value: state.position.inSeconds.toDouble(),
                    min: Duration.zero.inSeconds.toDouble(),
                    max: state.duration.inSeconds.toDouble(),
                    activeColor: Colors.green,
                    inactiveColor: Colors.green[200],
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
                  style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: Duration.zero.inSeconds.toDouble(),
                  min: Duration.zero.inSeconds.toDouble(),
                  max: Duration.zero.inSeconds.toDouble(),
                  activeColor: Colors.green,
                  inactiveColor: Colors.green[200],
                  onChanged: (double value) {},
                ),
              ),
              Text(
                _formatDuration(Duration.zero),
                style: TextStyle(color: Colors.white),
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
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(color: Colors.black45),
              ],
            ),
            child: IconButton(
              color: Colors.white,
              icon: state is FinishState
                  ? Icon(Icons.replay)
                  : AnimatedIcon(
                      icon: AnimatedIcons.pause_play,
                      progress: Tween<double>(begin: 0.0, end: 1.0).animate(
                        playAnimationController,
                      ),
                    ),
              onPressed: () {
                if (state is FinishState) {
                  BlocProvider.of<PlayerBloc>(context).add(FetchVideo());
                } else if (playAnimationController.status.index != 0) {
                  BlocProvider.of<PlayerBloc>(context).add(PlayVideo());
                  playAnimationController.reverse();
                } else {
                  BlocProvider.of<PlayerBloc>(context).add(PauseVideo());
                  playAnimationController.forward();
                }
              },
            ),
          );

        if (state is ErrorState)
          return Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              Text('${state.error}'),
            ],
          );

        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
