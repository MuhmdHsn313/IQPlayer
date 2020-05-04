import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iqplayer/src/models/subtitle.dart';

class SubtitleState extends Equatable {
  final String data;

  const SubtitleState(this.data);

  factory SubtitleState.initial() => SubtitleState(
          ''
      );

  SubtitleState copyWith(Subtitle subtitle) =>
      SubtitleState(subtitle.data ?? this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => "SubtitleState { date: $data }";
}
