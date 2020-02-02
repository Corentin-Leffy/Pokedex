import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/fonctionnalites/lister_pokemons/domaine/entites/id.dart';

class Pokemon extends Equatable {
  final Id id;
  final String nom;
  final int baseExperience;
  final int taille;
  final bool estParDefaut;
  final int ordre;
  final int poids;

  Pokemon(
      {@required this.id,
      @required this.nom,
      @required this.baseExperience,
      @required this.taille,
      @required this.estParDefaut,
      @required this.ordre,
      @required this.poids});

  @override
  List<Object> get props =>
      [id, nom, baseExperience, taille, estParDefaut, ordre, poids];
}
