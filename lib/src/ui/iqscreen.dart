import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IQScreen extends StatefulWidget {
  final String title;
  final String description;
  final VideoPlayerController videoPlayerController;
  final String subtitleUrl;

  const IQScreen({
    Key key,
    this.title,
    this.description,
    this.videoPlayerController,
    this.subtitleUrl,
  }) : super(key: key);

  @override
  _IQScreenState createState() => _IQScreenState();
}

class _IQScreenState extends State<IQScreen>
    with SingleTickerProviderStateMixin {
  AnimationController playAnimationController;

  String get title => widget.title;

  String get description => widget.description;

  VideoPlayerController get videoPlayerController =>
      widget.videoPlayerController;

  String get subtitleUrl => widget.subtitleUrl;

  @override
  void initState() {
    playAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    videoPlayerController.initialize();
    videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    playAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(
                videoPlayerController,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 400),
              child: Container(
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
                    _buildAppBar(),
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
                    _buildBottomScreen(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
          ),
          Text(
            description,
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
          icon: Icon(Icons.screen_rotation),
          tooltip: 'Lock Rotation',
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.lock_open),
          tooltip: 'Lock Controls',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomScreen() {
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
