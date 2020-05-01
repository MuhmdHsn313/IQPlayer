import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/screen/bloc.dart';

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
                          onPressed: () {},
                        ),
                        _mainButton(),
                        IconButton(
                          icon: Icon(
                            Icons.forward_10,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    _buildBottomScreen(context, state),
                  ],
                ),
              )
            : Container(
                alignment: Alignment.topCenter,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(),
                  actions: <Widget>[
                    IconButton(
                      icon:
                          Icon(state.lockScreen ? Icons.lock : Icons.lock_open),
                      tooltip:
                          state.lockScreen ? 'Unlock Screen' : 'Lock Screen',
                      onPressed: () => BlocProvider.of<ScreenBloc>(context).add(
                        state.lockScreen ? UnlockScreen() : LockScreen(),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            '01:38',
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Slider(
              value: 40,
              min: 0,
              max: 100,
              activeColor: Colors.green,
              inactiveColor: Colors.green[200],
              onChanged: (value) {},
            ),
          ),
          Text(
            '19:08:18',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _mainButton() {
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
        icon: AnimatedIcon(
          icon: AnimatedIcons.pause_play,
          progress: Tween<double>(begin: 0.0, end: 1.0).animate(
            playAnimationController,
          ),
        ),
        onPressed: () {
          if (playAnimationController.status.index == 0)
            playAnimationController.forward();
          else
            playAnimationController.reverse();
        },
      ),
    );
  }
}
