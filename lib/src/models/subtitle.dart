import 'package:equatable/equatable.dart';

///! The user have not to use this class.
/// This model class contorl the subtitle data.
class Subtitle extends Equatable {
  final Duration start;
  final Duration end;
  final String data;

  const Subtitle({
    required this.start,
    required this.end,
    required this.data,
  });

  bool operator >(Subtitle other) => this.start > other.start;

  bool operator <(Subtitle other) => this.start < other.start;

  bool operator <=(Subtitle other) => this.start <= other.start;

  bool operator >=(Subtitle other) => this.start >= other.start;

  int compareTo(Subtitle other) =>
      this.start.inMilliseconds.compareTo(other.start.inMilliseconds);

  @override
  List<Object> get props => [start, end, data];
}
