import 'package:dartz/dartz.dart';

import 'erreur.dart';

abstract class CasUtilisation<Type, Parametres> {
  Future<Either<Erreur, Type>> call(Parametres parametres);
}

class SansParametres {}
