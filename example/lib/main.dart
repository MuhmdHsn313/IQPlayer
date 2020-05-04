import 'package:flutter/material.dart';
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
        child: RaisedButton(
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
                  subtitleProvider: SubtitleProvider.fromNetwork(
                      'https://duoidi6ujfbv.cloudfront.net/media/0/subtitles/5675420c9d9a3.vtt'
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}