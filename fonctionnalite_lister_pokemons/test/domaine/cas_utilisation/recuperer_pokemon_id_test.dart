import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/cas_utilisation/recuperer_pokemon_id.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/entites/Pokemon.dart';
import 'package:mockito/mockito.dart';

import '../depot/simulacre_depot_pokemon.dart';

void main() {
  RecupererPokemonViaId recupererPokemonViaId;
  SimulacreDepotPokemon simulacreDepotPokemon;
  int id = 1;
  Pokemon pokemon = Pokemon(
      id: id,
      order: 1,
      baseExperience: 64,
      name: "Bulbizarre",
      weight: 69,
      height: 7,
      isDefault: true);

  setUp(() {
    simulacreDepotPokemon = SimulacreDepotPokemon();
    recupererPokemonViaId = RecupererPokemonViaId(simulacreDepotPokemon);
  });

  test("Doit retourner un Pokémon depuis le dépôt grâce à son identifiant",
      () async {
    when(simulacreDepotPokemon.recupererPokemon(any))
        .thenAnswer((_) async => Right(pokemon));

    final resultat = await recupererPokemonViaId(Parametres(id: id));

    expect(resultat, equals(Right(pokemon)));
    verify(simulacreDepotPokemon.recupererPokemon(id));
    verifyNoMoreInteractions(simulacreDepotPokemon);
  });
}
