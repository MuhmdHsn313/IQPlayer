import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Subtitle extends Equatable {
  final Duration start;
  final Duration end;
  final String data;

  const Subtitle({
    @required this.start,
    @required this.end,
    @required this.data,
  })  : assert(start != null),
        assert(end != null),
        assert(data != null);

  bool operator >(Subtitle other) => this.start > other.start;

  bool operator <(Subtitle other) => this.start < other.start;

  bool operator <=(Subtitle other) => this.start <= other.start;

  bool operator >=(Subtitle other) => this.start >= other.start;

  @override
  List<Object> get props => [start, end, data];
}
