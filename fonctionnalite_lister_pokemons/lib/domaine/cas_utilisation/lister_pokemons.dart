import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../erreur.dart';
import '../depot/depot_pokemon.dart';
import '../entites/Pokemon.dart';

class ListerPokemons {
  final DepotPokemon depotPokemon;

  ListerPokemons(this.depotPokemon);

  Future<Either<Erreur, Pokemon>> execute({
    @required int id,
  }) async =>
      await depotPokemon.recupererPokemon(id);
}
