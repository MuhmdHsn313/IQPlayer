import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqplayer/src/blocs/subtitle/bloc.dart';

class SubtitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtitleBloc, SubtitleState>(
      bloc: BlocProvider.of<SubtitleBloc>(context),
      builder: (context, state) => Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          state.data,
          textAlign: TextAlign.center,
          style: TextStyle(
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
    );
  }
}
