# IQPlayer

Simple video player with subtitle wrote for flutter.

![GitHub release (latest by date)](https://img.shields.io/github/v/release/Muhmdhsn313/IQPlayer?style=flat-square)
![GitHub](https://img.shields.io/github/license/muhmdhsn313/iqplayer?style=flat-square)
![GitHub followers](https://img.shields.io/github/followers/muhmdhsn313?style=social)

> This package as a Gift for my teacher and my leader [Mr. Muqtada Al-Sadr](https://twitter.com/Mu_AlSadr).

> Proudly made by [BLoC](https://pub.dev/packages/flutter_bloc).

## Features
1. [x] Play video from Assets, Files, Network by `VideoPlayerController` from video_player.
2. [x] Parse subtitles from Assets, Files, Network `SubtitleProvider` class.
3. [ ] Custom theme you can use with `IQTheme` class.
4. [x] Support Subtitles:
   1. [x] VTT format
   2. [ ] SRT format
   3. [ ] User define format
5. [x] **IQScreen:** a video player scaffold screen.
6. [ ] **IQPlayer:** a widget enable you to watch video implement with your screen.
7. [x] **IQParser:** a subtitle package that view subtitles, included the widget and parser

# Installation
##  1. Depend on
Go to `pubspec.yaml` and set the dependencies like:

```yaml
dependencies:
  iqplayer: <latest_version>
```

Install packages from the command line with Flutter:

```shell script
flutter pub get
```

## 2. Install

### Android
Ensure the following permission is present in your Android Manifest file, located in <project root>/android/app/src/main/AndroidManifest.xml:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```
The Flutter project template adds it, so it may already be there.
### IOS

Warning: The video player is not functional on iOS simulators. An iOS device must be used during development/testing.

Add the following entry to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
```
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```
This entry allows your app to access video files by URL.


## 3. Import

Now in your Dart code, you can use:

```dart
import "package:iqplayer/iqplayer.dart";
```
# Componets
1. **IQScreen:**
```dart
IQScreen(
  videoPlayerController = VideoPlayerController.network(""),
  subtitleProvider: SubtitleProvider.fromNetwork(""),
  title: "Simple Video",
  description: "Simple Description",
);
```
2. **IQPlayer:**

  > In development.

3. **IQParser:**

> Note: It is used automatically with `IQScreen` and you can use and display data with `SubtitleProvider`.

```dart
BlocProvider<SubtitleBloc>(
  create: (context) =>
    SubtitleBloc(
      SubtitleProvider.fromNetwork(""),
    )..add(FetchSubtitles()),
    child: MyParser(),
);
```
# Using

1. Start use `IQScreen` with Navigator:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) => IQScreen(
    title: "",
    description: "",
    videoPlayerController: VideoPlayerController.network(""),
    subtitleProvider: SubtitleProvider.fromNetwork(""),
   ),
  ),
);
```

2. Using of `IQParser`:

> You have to use `BlocProvider` with `SubtitleProvider` to configure subtitles.

```dart
// In Your widget
BlocProvider<SubtitleBloc>(
  create: (context) =>
    SubtitleBloc(
      SubtitleProvider.fromNetwork(""),
    )..add(FetchSubtitles()),
    child: MyParser(),
);

// new parser class, you can exclude `MyParser`
class MyParser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IQParser();
  }
}
```
> Note: You can exclude "MyParser" and delete it!

> Note: What is the reason for creating `MyParser`? [see this](https://bloclibrary.dev/#/faqs?id=blocproviderof-fails-to-find-bloc)

# Example
```dart
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
```