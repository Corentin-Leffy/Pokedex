import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseDeDonnees {
  static const VERSION = 1;
  static const NOM = 'pokemons.db';

  Database baseDeDonnees;

  Future ouvrir() async {
    baseDeDonnees = await openDatabase(
      join(await getDatabasesPath(), BaseDeDonnees.NOM),
      onCreate: (baseDeDonnees, version) async {
        await baseDeDonnees.execute(
          "CREATE TABLE pokemons("
          "id INTEGER PRIMARY KEY,"
          " nom TEXT,"
          " base_experience INTEGER,"
          " taille INTEGER,"
          " est_par_defaut INTEGER,"
          " ordre INTEGER,"
          " poids INTEGER"
          ")",
        );
      },
      version: BaseDeDonnees.VERSION,
    );
  }

  Future fermer() async => baseDeDonnees.close();
}
