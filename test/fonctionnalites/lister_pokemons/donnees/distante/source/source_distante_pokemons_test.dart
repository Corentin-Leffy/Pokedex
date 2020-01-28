import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/modele_pokemon.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/source/source_distante_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/source/source_distante_pokemons_impl.dart';
import 'package:pokedex/socle/erreur/exception.dart';

import '../../../../../fixtures.dart';

class SimulacreHttpClient extends Mock implements http.Client {}

void main() {
  SourceDistantePokemons sourceDistantePokemons;
  SimulacreHttpClient httpClient;

  setUp(() {
    httpClient = SimulacreHttpClient();
    sourceDistantePokemons = SourceDistantePokemonsImpl(client: httpClient);
  });

  void initialiseReponseServeur({@required int code, @required String corps}) {
    when(httpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(corps, code));
  }

  group("Récupère un pokémon depuis la source distante", () {
    final pokemonId = 1;

    test("Requête via une méthode GET une URL avec l'ID du pokémon", () {
      initialiseReponseServeur(code: 200, corps: fixture("pokemon.json"));

      sourceDistantePokemons.recuperePokemonVia(id: pokemonId);

      verify(httpClient.get(
        "https://pokeapi.co/api/v2/pokemon/$pokemonId/",
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test("Récupère le pokémon quand le code HTTP répondu est 200", () async {
      final pokemon =
          ModelePokemon.aPartirDeJson(json.decode(fixture("pokemon.json")));

      initialiseReponseServeur(code: 200, corps: fixture("pokemon.json"));

      final resultat =
          await sourceDistantePokemons.recuperePokemonVia(id: pokemonId);

      expect(resultat, equals(pokemon));
    });

    test("Déclenche un exception quand le code HTTP répondu n'est pas 200",
        () async {
      initialiseReponseServeur(
          code: 404, corps: "Oups ! Votre requête n'a pas abouti...");

      final invocation = sourceDistantePokemons.recuperePokemonVia;

      expect(() => invocation(id: pokemonId), throwsA(isA<ExceptionServeur>()));
    });

    test(
        "Déclenche un exception quand le code HTTP répondu est 200 mais que le corps est vide",
        () async {
      initialiseReponseServeur(code: 200, corps: "");

      final invocation = sourceDistantePokemons.recuperePokemonVia;

      expect(() => invocation(id: pokemonId), throwsA(isA<ExceptionServeur>()));
    });
  });
}
