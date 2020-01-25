import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fonctionnalite_lister_pokemons/domaine/entites/pokemon.dart';
import 'package:fonctionnalite_lister_pokemons/donnees/distante/modele/modele_pokemon.dart';

import '../../../fixtures.dart';

void main() {
  final modelePokemon = ModelePokemon(
      id: 1,
      ordre: 1,
      baseExperience: 0,
      nom: "Test",
      poids: 100,
      taille: 1,
      estParDefaut: true);

  test("Doit être une sous-classe de Pokémon", () async {
    expect(modelePokemon, isA<Pokemon>());
  });

  group("À partir de JSON", () {
    test("Doit retourner un modèle valide à partir d'un JSON composé d'entiers",
        () async {
      final Map<String, dynamic> response =
          json.decode(fixture("reponse.json"));

      final resultat = ModelePokemon.aPartirDeJson(response);

      expect(resultat, equals(modelePokemon));
    });

    test("Doit retourner un modèle valide à partir d'un JSON composé de doubles",
            () async {
          final Map<String, dynamic> response =
          json.decode(fixture("reponse_avec_double.json"));

          final resultat = ModelePokemon.aPartirDeJson(response);

          expect(resultat, equals(modelePokemon));
        });
  });
}
