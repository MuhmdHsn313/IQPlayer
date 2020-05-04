import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/player/bloc.dart';
import 'package:iqplayer/src/blocs/screen/screen_bloc.dart';
import 'package:iqplayer/src/blocs/subtitle/bloc.dart';
import 'package:iqplayer/src/ui/screen_controllers.dart';
import 'package:iqplayer/src/utils/subtitle_provider.dart';
import 'package:video_player/video_player.dart';

class IQScreen extends StatefulWidget {
  final String title;
  final String description;
  final VideoPlayerController videoPlayerController;
  final SubtitleProvider subtitleProvider;

  const IQScreen({
    Key key,
    @required this.title,
    @required this.videoPlayerController,
    this.description: '',
    this.subtitleProvider,
  })  : assert(title != null),
        assert(videoPlayerController != null),
        super(key: key);

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

  SubtitleProvider get subtitleProvider => widget.subtitleProvider;

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
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ScreenBloc>(
                  create: (context) => ScreenBloc(
                    title: title,
                    description: description,
                  ),
                ),
                BlocProvider<PlayerBloc>(
                  create: (context) =>
                      PlayerBloc(videoPlayerController)..add(FetchVideo()),
                ),
                BlocProvider<SubtitleBloc>(
                  create: (context) =>
                      SubtitleBloc(subtitleProvider)..add(FetchSubtitles()),
                ),
              ],
              child: ScreenControllers(
                playAnimationController: playAnimationController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
