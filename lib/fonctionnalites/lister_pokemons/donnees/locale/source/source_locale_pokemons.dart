import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/modele/pokemon_local.dart';

abstract class SourceLocalePokemon {
  /// Récupére le [PokemonLocal] sauvegardé localement avec l'id passé en
  /// paramètres.
  ///
  /// Déclenche une [AucuneDonneeLocaleException] s'il n'y a pas de données.
  Future<PokemonLocal> recuperePokemonVia({@required int id});

  /// Sauvegarde le pokémon dans la base de données locale.
  Future<void> sauvegardePokemon(PokemonDistant pokemon);
}
