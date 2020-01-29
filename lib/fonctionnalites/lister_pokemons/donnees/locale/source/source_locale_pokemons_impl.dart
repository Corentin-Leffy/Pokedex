import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/distante/modele/pokemon_distant.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/modele/pokemon_local.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/donnees/locale/source/source_locale_pokemons.dart';
import 'package:pokedex/socle/erreur/exception.dart';
import 'package:sqflite/sqflite.dart';

class SourceLocalePokemonImpl implements SourceLocalePokemon {
  final Database baseDeDonnees;

  SourceLocalePokemonImpl(this.baseDeDonnees);

  static const NOM_TABLE = "pokemons";

  @override
  Future<PokemonLocal> recuperePokemonVia({@required int id}) async {
    final lignes =
        await baseDeDonnees.query(NOM_TABLE, where: "id = ?", whereArgs: [id]);
    baseDeDonnees.close();

    final ligne = lignes.firstWhere(
        (ligne) => ligne != null && ligne.isNotEmpty,
        orElse: () => throw AucuneDonneeLocaleException());

    return PokemonLocal.aPartirDeJson(ligne);
  }

  @override
  Future<void> sauvegardePokemon(PokemonDistant pokemon) async {
    await baseDeDonnees.insert(NOM_TABLE, pokemon.enJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
