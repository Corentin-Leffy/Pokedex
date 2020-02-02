import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/base_experience.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/id.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';

class PokemonDistant extends Pokemon {
  PokemonDistant(
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

  factory PokemonDistant.aPartirDeJson(Map<String, dynamic> json) =>
      PokemonDistant(
        id: Id.aPartirDe(json: json),
        nom: json["name"],
        ordre: json["order"],
        estParDefaut: json["is_default"],
        poids: (json["weight"] as num).toInt(),
        taille: (json["height"] as num).toInt(),
        baseExperience: BaseExperience.aPartirDe(json: json),
      );

  Map<String, dynamic> enJson() {
    final Map<String, dynamic> json = {
      'height': taille,
      'is_default': estParDefaut,
      'name': nom,
      'order': ordre,
      'weight': poids
    };

    json.addEntries([id.enJson, baseExperience.enJson]);

    return json;
  }

  @override
  String toString() => "[${super.props.join(",")}]";
}
