import 'package:dartz/dartz.dart';
import 'package:fonctionnalite_lister_pokemons/cas_utilisation.dart';
import 'package:meta/meta.dart';

import '../../erreur.dart';
import '../depot/depot_pokemon.dart';
import '../entites/Pokemon.dart';

class RecupererPokemonViaId extends CasUtilisation<Pokemon, Parametres> {
  final DepotPokemon depotPokemon;

  RecupererPokemonViaId(this.depotPokemon);

  Future<Either<Erreur, Pokemon>> call(Parametres parametres) async =>
      await depotPokemon.recupererPokemon(parametres.id);
}

class Parametres {
  final int id;

  Parametres({@required this.id});
}
