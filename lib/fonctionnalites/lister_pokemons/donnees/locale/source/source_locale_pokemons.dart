import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/modele_pokemon.dart';

abstract class SourceLocalePokemon {
  /// Récupére le dernier [ModelePokemon] sauvegardé localement lors de la
  /// dernière connexion internet.
  ///
  /// Déclenche une [AucuneDonneeLocalException] s'il n'y a pas de données.
  Future<ModelePokemon> recupereDernierPokemon();

  /// Sauvegarde le pokémon dans la base de données locale.
  Future<void> sauvegardePokemon(ModelePokemon pokemon);
}
