import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const VERSION = 1;
const NOM = 'pokemons.db';

Future<Database> ouvrirBaseDeDonnees() async => openDatabase(
      join(await getDatabasesPath(), NOM),
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
      version: VERSION,
    );
