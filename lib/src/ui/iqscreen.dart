import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/screen/screen_bloc.dart';
import 'package:iqplayer/src/ui/screen_controllers.dart';
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
              child: BlocProvider<ScreenBloc>(
                create: (context) => ScreenBloc(
                  title: title,
                  description: description,
                ),
                child: ScreenControllers(
                  playAnimationController: playAnimationController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
