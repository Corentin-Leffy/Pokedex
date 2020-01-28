import 'package:data_connection_checker/data_connection_checker.dart';

import 'information_reseau_internet.dart';

class InformationsReseauInternetImpl implements InformationsReseauInternet {
  final DataConnectionChecker verificateurDonneesInternet;

  InformationsReseauInternetImpl(this.verificateurDonneesInternet);

  @override
  Future<bool> get aInternet => verificateurDonneesInternet.hasConnection;
}
