import 'package:meta/meta.dart';

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;

  Pokemon(
      {@required this.id,
      @required this.name,
      @required this.baseExperience,
      @required this.height,
      @required this.isDefault,
      @required this.order,
      @required this.weight});
}
