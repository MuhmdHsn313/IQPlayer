import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iqplayer/iqplayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IQPlayer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'IQPlayer Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Open IQPlayer'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => IQScreen(
                      title: title,
                      description: 'Simple video as a demo video',
                      videoPlayerController: VideoPlayerController.network(
                        'https://d11b76aq44vj33.cloudfront.net/media/720/video/5def7824adbbc.mp4',
                      ),
                      subtitleProvider: SubtitleProvider.fromString(
                        """WEBVTT

                            00:00:00.650 --> 00:00:03.000
                            <p style="color:blue">Hello World</p>

                            00:00:03.024 --> 00:00:07.524
                            <i>Mindmarker je krátká zpráva formou
                            videa, souborů PDF...</i>

                            00:00:07.548 --> 00:00:12.448
                            <span style='color:brown'>colorful</span>

                            00:00:12.472 --> 00:00:16.072
                            Mindmarker budeš obdržovat
                            ve specifický chvílích...

                            00:00:16.100 --> 00:00:20.100
                            abychom lépe utužili tvé znalosti.""",
                      ),
                      // subtitleProvider: SubtitleProvider.fromNetwork(
                      //     'https://duoidi6ujfbv.cloudfront.net/media/0/subtitles/5675420c9d9a3.vtt'),
                      iqTheme: IQTheme(
                        loadingProgress: SpinKitCircle(
                          color: Colors.red,
                        ),
                        playButtonColor: Colors.transparent,
                        videoPlayedColor: Colors.indigo,
                        playButton: (BuildContext context, bool isPlay,
                            AnimationController animationController) {
                          if (isPlay)
                            return Icon(
                              Icons.pause_circle_filled,
                              color: Colors.red,
                              size: 50,
                            );
                          return Icon(
                            Icons.play_circle_outline,
                            color: Colors.red,
                            size: 50,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
