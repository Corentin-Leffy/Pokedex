import 'package:fonctionnalite_lister_pokemons/domaine/entites/pokemon.dart';
import 'package:meta/meta.dart';

class ModelePokemon extends Pokemon {
  ModelePokemon(
      {@required id,
      @required nom,
      @required baseExperience,
      @required taille,
      @required estParDefaut,
      @required ordre,
      @required poids})
      : super(
            id: id,
            nom: nom,
            baseExperience: baseExperience,
            taille: taille,
            estParDefaut: estParDefaut,
            ordre: ordre,
            poids: poids);

  factory ModelePokemon.aPartirDeJson(Map<String, dynamic> json) =>
      ModelePokemon(
          id: json["id"],
          nom: json["name"],
          baseExperience: (json["base_experience"] as num).toInt(),
          taille: (json["height"] as num).toInt(),
          estParDefaut: json["is_default"],
          ordre: json["order"],
          poids: (json["weight"] as num).toInt());

  @override
  String toString() => "[${super.props.join(",")}]";
}
