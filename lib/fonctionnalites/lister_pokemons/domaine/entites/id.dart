import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Id extends Equatable {
  static const String ID = "id";

  final int value;

  Id(this.value);

  factory Id.aPartirDe({@required Map<String, dynamic> json}) => Id(json[ID]);

  @override
  List<Object> get props => [value];

  MapEntry<String, int> get enJson => MapEntry(ID, value);
}
