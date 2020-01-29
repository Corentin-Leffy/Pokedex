import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/socle/erreur/exception.dart';

abstract class SourceDistantePokemons {
  /// Appelle l'API de pokémon pour récupérer un Pokémon grâce à son id.
  ///
  /// Déclenche une [ExceptionServeur] à la moindre erreur.
  Future<PokemonDistant> recuperePokemonVia({@required int id});
}
