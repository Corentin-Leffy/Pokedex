import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/depot/depot_pokemons.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/base_experience.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/id.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/depot/depot_pokemons_impl.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/modele/pokemon_local.dart';
import 'package:pokedex/socle/erreur/erreur.dart';
import 'package:pokedex/socle/erreur/exception.dart';

import '../../../../socle/plateforme/simulacre_information_reseau_internet.dart';
import '../distante/source/simulacre_source_distante_pokemons.dart';
import '../locale/source/simulacre_source_locale_pokemon.dart';

void main() {
  DepotPokemons depotPokemons;
  SimulacreSourceDistantePokemons sourceDistantePokemons;
  SimulacreSourceLocalePokemons sourceLocalePokemons;
  SimulacreInformationsReseauInternet informationsReseauInternet;

  setUp(() {
    sourceDistantePokemons = SimulacreSourceDistantePokemons();
    sourceLocalePokemons = SimulacreSourceLocalePokemons();
    informationsReseauInternet = SimulacreInformationsReseauInternet();
    depotPokemons = DepotPokemonsImpl(sourceDistantePokemons,
        sourceLocalePokemons, informationsReseauInternet);
  });

  Id id = Id(1);
  PokemonDistant pokemonDistant = PokemonDistant(
      id: id,
      ordre: 1,
      baseExperience: BaseExperience(64),
      nom: "Bulbizarre",
      poids: 69,
      taille: 7,
      estParDefaut: true);

  PokemonLocal pokemonLocal = PokemonLocal(
      id: id,
      ordre: 1,
      baseExperience: BaseExperience(64),
      nom: "Bulbizarre",
      poids: 69,
      taille: 7,
      estParDefaut: true);

  group("Avec une connexion internet", () {
    setUp(() {
      when(informationsReseauInternet.aInternet).thenAnswer((_) async => true);
    });

    test("Récupére un pokémon depuis la source distante", () async {
      when(sourceDistantePokemons.recuperePokemonVia(id: id))
          .thenAnswer((_) async => pokemonDistant);

      final resultat = await depotPokemons.recuperePokemonVia(id: id);

      verify(sourceDistantePokemons.recuperePokemonVia(id: id));
      expect(resultat, equals(Right(pokemonDistant)));
    });

    test("Sauvegarde le pokémon dans la base de données locale", () async {
      when(sourceDistantePokemons.recuperePokemonVia(id: id))
          .thenAnswer((_) async => pokemonDistant);

      await depotPokemons.recuperePokemonVia(id: id);

      verify(sourceDistantePokemons.recuperePokemonVia(id: id));
      verify(sourceLocalePokemons.sauvegardePokemon(any));
    });
    test(
        "Déclenche une erreur serveur dès que l'appel à la source de données distante échoue",
        () async {
      when(sourceDistantePokemons.recuperePokemonVia(id: id))
          .thenThrow(ExceptionServeur());

      final resultat = await depotPokemons.recuperePokemonVia(id: id);

      verify(sourceDistantePokemons.recuperePokemonVia(id: id));
      verifyZeroInteractions(sourceLocalePokemons);
      expect(resultat, equals(Left(ErreurServeur())));
    });
  });

  group("Sans connexion internet", () {
    setUp(() {
      when(informationsReseauInternet.aInternet).thenAnswer((_) async => false);
    });

    void verifieInteractionsAvecSourceLocaleSeulement() {
      verify(sourceLocalePokemons.recuperePokemonVia(id: id));
      verifyZeroInteractions(sourceDistantePokemons);
    }

    test("Récupére le pokémon depuis la source de données locale", () async {
      when(sourceLocalePokemons.recuperePokemonVia(id: id))
          .thenAnswer((_) async => pokemonLocal);

      final resultat = await depotPokemons.recuperePokemonVia(id: id);

      verifieInteractionsAvecSourceLocaleSeulement();
      expect(resultat, equals(Right(pokemonLocal)));
    });

    test(
        "Déclenche une erreur de source de données locale quand il n'y a pas de pokémon",
        () async {
      when(sourceLocalePokemons.recuperePokemonVia(id: id))
          .thenThrow(ExceptionLocale());

      final resultat = await depotPokemons.recuperePokemonVia(id: id);

      verifieInteractionsAvecSourceLocaleSeulement();
      expect(resultat, equals(Left(ErreurLocale())));
    });
  });
}
