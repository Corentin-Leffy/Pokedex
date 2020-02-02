import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/id.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/socle/erreur/erreur.dart';

abstract class DepotPokemons {
  Future<Either<Erreur, Pokemon>> recuperePokemonVia({@required Id id});
}
