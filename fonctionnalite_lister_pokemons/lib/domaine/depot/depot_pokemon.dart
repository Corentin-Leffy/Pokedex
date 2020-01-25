import 'package:dartz/dartz.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/entites/pokemon.dart';
import 'package:fonctionnalite_lister_pokemons/erreur.dart';

abstract class DepotPokemon {
  Future<Either<Erreur, Pokemon>> recupererPokemon(int id);
}
