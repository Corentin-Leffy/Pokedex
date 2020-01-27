import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/depot/depot_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/socle/cas_utilisation.dart';
import 'package:pokedex/socle/erreur.dart';

class RecupererPokemonViaId extends CasUtilisation<Pokemon, Parametres> {
  final DepotPokemons depotPokemon;

  RecupererPokemonViaId(this.depotPokemon);

  Future<Either<Erreur, Pokemon>> call(Parametres parametres) async =>
      await depotPokemon.recupererPokemon(parametres.id);
}

class Parametres {
  final int id;

  Parametres({@required this.id});
}
