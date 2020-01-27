import 'package:dartz/dartz.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/depot/depot_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/socle/erreur.dart';

class DepotPokemonsImpl implements DepotPokemons {
  @override
  Future<Either<Erreur, Pokemon>> recupererPokemon(int id) {
    return null;
  }
}
