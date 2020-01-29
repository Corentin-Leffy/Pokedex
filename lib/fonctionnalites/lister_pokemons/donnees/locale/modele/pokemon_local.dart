import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';

class PokemonLocal extends Pokemon {
  PokemonLocal(
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

  factory PokemonLocal.aPartirDeJson(Map<String, dynamic> json) => PokemonLocal(
        id: json["id"],
        nom: json["name"],
        ordre: json["order"],
        estParDefaut: json["is_default"] == 1 || json["is_default"],
        poids: (json["weight"] as num).toInt(),
        taille: (json["height"] as num).toInt(),
        baseExperience: (json["base_experience"] as num).toInt(),
      );

  @override
  String toString() => "[${super.props.join(",")}]";
}
