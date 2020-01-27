import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/depot/depot_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/source/source_distante_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/source/source_locale_pokemons.dart';
import 'package:pokedex/socle/erreur/erreur.dart';
import 'package:pokedex/socle/erreur/exception.dart';
import 'package:pokedex/socle/plateforme/information_reseau_internet.dart';

class DepotPokemonsImpl implements DepotPokemons {
  final SourceDistantePokemons sourceDistantePokemons;
  final SourceLocalePokemon sourceLocalePokemons;
  final InformationsReseauInternet informationsReseauInternet;

  DepotPokemonsImpl(this.sourceDistantePokemons, this.sourceLocalePokemons,
      this.informationsReseauInternet);

  @override
  Future<Either<Erreur, Pokemon>> recuperePokemonVia(
          {@required int id}) async =>
      await informationsReseauInternet.aInternet
          ? await _recuperePokemonDepuisSourceDistante(id)
          : await _recuperePokemonDepuisSourceLocale();

  Future<Either<Erreur, Pokemon>> _recuperePokemonDepuisSourceDistante(
      int id) async {
    try {
      final pokemon = await sourceDistantePokemons.recuperePokemonVia(id: id);
      sourceLocalePokemons.sauvegardePokemon(pokemon);
      return Right(pokemon);
    } on ExceptionServeur {
      return Left(ErreurServeur());
    }
  }

  Future<Either<Erreur, Pokemon>> _recuperePokemonDepuisSourceLocale() async {
    try {
      final pokemon = await sourceLocalePokemons.recupereDernierPokemon();
      return Right(pokemon);
    } on ExceptionLocale {
      return Left(ErreurLocale());
    }
  }
}
