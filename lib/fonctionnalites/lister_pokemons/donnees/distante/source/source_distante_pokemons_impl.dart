import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/source/source_distante_pokemons.dart';
import 'package:pokedex/socle/erreur/exception.dart';

class SourceDistantePokemonsImpl implements SourceDistantePokemons {
  final http.Client client;

  SourceDistantePokemonsImpl({@required this.client});

  @override
  Future<PokemonDistant> recuperePokemonVia({int id}) async {
    final reponse = await client.get(
      "https://pokeapi.co/api/v2/pokemon/$id/",
      headers: {'Content-Type': 'application/json'},
    );

    if (reponse.statusCode == 200 && reponse.body.isNotEmpty) {
      return PokemonDistant.aPartirDeJson(json.decode(reponse.body));
    }
    throw ExceptionServeur();
  }
}
