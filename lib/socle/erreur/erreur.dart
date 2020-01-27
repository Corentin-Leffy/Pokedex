import 'package:equatable/equatable.dart';

abstract class Erreur extends Equatable {
  final List properties;

  Erreur([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => this.properties;
}

class ErreurServeur extends Erreur {}

class ErreurLocale extends Erreur {}
