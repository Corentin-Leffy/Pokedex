import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/base_experience.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/id.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/pokemon.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/modele/pokemon_local.dart';

import '../../../../../fixtures.dart';

void main() {
  final pokemonLocal = PokemonLocal(
      id: Id(1),
      ordre: 1,
      baseExperience: BaseExperience(0),
      nom: "Test",
      poids: 100,
      taille: 1,
      estParDefaut: true);

  test("Est une sous-classe de Pokémon", () async {
    expect(pokemonLocal, isA<Pokemon>());
  });

  group("À partir de JSON", () {
    test("Retourne un modèle valide à partir d'un JSON composé d'entiers",
        () async {
      final Map<String, dynamic> response =
          json.decode(fixture("reponse.json"));

      final resultat = PokemonLocal.aPartirDeJson(response);

      expect(resultat, equals(pokemonLocal));
    });

    test("Retourne un modèle valide à partir d'un JSON composé de doubles",
        () async {
      final Map<String, dynamic> response =
          json.decode(fixture("reponse_avec_double.json"));

      final resultat = PokemonLocal.aPartirDeJson(response);

      expect(resultat, equals(pokemonLocal));
    });
  });
}
