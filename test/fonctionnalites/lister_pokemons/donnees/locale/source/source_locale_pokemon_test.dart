import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/modele/pokemon_local.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/source/source_locale_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/source/source_locale_pokemons_impl.dart';
import 'package:pokedex/socle/erreur/exception.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../fixtures.dart';
import 'simulacre_base_donnees.dart';

void main() {
  SourceLocalePokemon sourceLocalePokemon;
  SimulacreBaseDeDonnees baseDeDonnees;

  setUp(() {
    baseDeDonnees = SimulacreBaseDeDonnees();
    sourceLocalePokemon = SourceLocalePokemonImpl(baseDeDonnees);
  });

  group("Depuis la source locale", () {
    final pokemonId = 1;
    final pokemonLocal = PokemonLocal.aPartirDeJson(pokemonEnJson());
    final pokemonDistant = PokemonDistant.aPartirDeJson(pokemonEnJson());

    test("Récupère un pokémon en base de données", () async {
      when(baseDeDonnees.query(any,
              where: anyNamed("where"), whereArgs: anyNamed("whereArgs")))
          .thenAnswer((_) async => [pokemonEnJson()]);

      final resultat =
          await sourceLocalePokemon.recuperePokemonVia(id: pokemonId);

      verify(baseDeDonnees
          .query("pokemons", where: "id = ?", whereArgs: [pokemonId]));
      expect(resultat, equals(pokemonLocal));
    });

    test("Déclenche une exception quand il n'y a pas de pokémon", () async {
      when(baseDeDonnees.query(any,
              where: anyNamed("where"), whereArgs: anyNamed("whereArgs")))
          .thenAnswer((_) async => []);

      final invocation = sourceLocalePokemon.recuperePokemonVia;

      expect(() => invocation(id: pokemonId),
          throwsA(isA<AucuneDonneeLocaleException>()));
    });

    test("Sauvegarde un pokémon dans la base de données locale", () async {
      sourceLocalePokemon.sauvegardePokemon(pokemonDistant);

      verify(baseDeDonnees.insert("pokemons", pokemonDistant.enJson(),
          conflictAlgorithm: ConflictAlgorithm.replace));
    });
  });
}

pokemonEnJson() => json.decode(fixture("pokemon.json"));
