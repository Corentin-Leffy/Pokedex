import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BaseExperience extends Equatable {
  static const BASE_EXPERIENCE = "base_experience";

  final int value;

  BaseExperience(this.value);

  factory BaseExperience.aPartirDe({@required Map<String, dynamic> json}) =>
      BaseExperience((json[BASE_EXPERIENCE] as num).toInt());

  @override
  List<Object> get props => [value];

  MapEntry<String, int> get enJson => MapEntry(BASE_EXPERIENCE, value);
}
