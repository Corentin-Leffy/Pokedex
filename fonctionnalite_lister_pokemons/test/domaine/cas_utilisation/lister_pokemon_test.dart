import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/cas_utilisation/lister_pokemons.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/entites/Pokemon.dart';
import 'package:mockito/mockito.dart';

import '../depot/simulacre_depot_pokemon.dart';

void main() {
  ListerPokemons listerPokemons;
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
    listerPokemons = ListerPokemons(simulacreDepotPokemon);
  });

  test("Doit retourner un Pokémon depuis le dépôt", () async {
    when(simulacreDepotPokemon.recupererPokemon(any))
        .thenAnswer((_) async => Right(pokemon));

    final resultat = await listerPokemons.execute(id: id);

    expect(resultat, equals(Right(pokemon)));
    verify(simulacreDepotPokemon.recupererPokemon(id));
    verifyNoMoreInteractions(simulacreDepotPokemon);
  });
}
