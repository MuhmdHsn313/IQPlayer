import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/player/bloc.dart';
import 'package:iqplayer/src/blocs/subtitle/bloc.dart';

import '../../iqplayer.dart';

class IQParser extends StatelessWidget {
  final IQTheme iqTheme;

  const IQParser({
    Key key,
    @required this.iqTheme,
  })  : assert(iqTheme != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width,
          child: Text(
            state.data,
            textAlign: TextAlign.center,
            style: iqTheme.subtitleStyle ??
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
          ),
        ),
      ),
    );
  }
}
