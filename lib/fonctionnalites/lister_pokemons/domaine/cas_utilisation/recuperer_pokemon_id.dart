import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/depot/depot_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/socle/cas_utilisation.dart';
import 'package:pokedex/socle/erreur/erreur.dart';

class RecupererPokemonViaId extends CasUtilisation<Pokemon, Parametre> {
  final DepotPokemons depotPokemon;

  RecupererPokemonViaId(this.depotPokemon);

  Future<Either<Erreur, Pokemon>> call(Parametre parametre) async =>
      await depotPokemon.recuperePokemonVia(id: parametre.id);
}

class Parametre {
  final int id;

  Parametre({@required this.id});
}
