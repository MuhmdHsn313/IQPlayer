import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../blocs/player/bloc.dart';
import '../blocs/subtitle/bloc.dart';

/// This widget for display subtitle, you can use only with bloc:
/// ```dart
///   // In Your widget
///   BlocProvider<SubtitleBloc>(
///     create: (context) =>
///       SubtitleBloc(
///         SubtitleProvider.fromNetwork(""),
///       )..add(FetchSubtitles()),
///    child: MyParser(),
///   );
///   //new parser class, you can exclude `MyParser`
///  class MyParser extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return IQParser();
///   }
///  }
/// ```
class IQParser extends StatelessWidget {
  /// To customization your text style of subtitle.
  final TextStyle subtitleDefaultTextStyle;

  const IQParser({
    Key key,
    @required this.subtitleDefaultTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return BlocListener<PlayerBloc, PlayerState>(
        bloc: BlocProvider.of<PlayerBloc>(context),
        listener: (context, state) {
          if (state is PlayingState)
            BlocProvider.of<SubtitleBloc>(context).add(
              UpdateSubtitle(state.position),
            );
        },
        child: BlocBuilder<SubtitleBloc, SubtitleState>(
          bloc: BlocProvider.of<SubtitleBloc>(context),
          builder: (context, state) => Container(
            child: state.data == null
                ? null
                : Builder(
                    builder: (context) {
                      return HTML.toRichText(
                        context,
                        '<p>${state.data}</p>',
                        defaultTextStyle: subtitleDefaultTextStyle ??
                            TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2.5,
                                )
                              ],
                            ),
                      );
                    },
                  ),
          ),
        ),
      );
    } catch (_) {
      return Container();
    }
  }
}
