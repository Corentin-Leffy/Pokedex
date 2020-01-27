import 'package:dartz/dartz.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/socle/erreur.dart';

abstract class DepotPokemons {
  Future<Either<Erreur, Pokemon>> recupererPokemon(int id);
}
