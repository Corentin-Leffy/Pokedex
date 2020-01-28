import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/socle/plateforme/information_reseau_internet.dart';
import 'package:pokedex/socle/plateforme/information_reseau_internet_impl.dart';

import 'simulacre_verificateur_donnees_internet.dart';

void main() {
  InformationsReseauInternet informationsReseauInternet;
  SimulacreVerificateurDonneesInternet verificateurDonneesInternet;

  setUp(() {
    verificateurDonneesInternet = SimulacreVerificateurDonneesInternet();
    informationsReseauInternet =
        InformationsReseauInternetImpl(verificateurDonneesInternet);
  });

  group("A une connexion internet", () {
    test("Transfert l'appel à la bibliothèque de vérification", () async {
      final aInternetFuture = Future.value(true);
      when(verificateurDonneesInternet.hasConnection)
          .thenAnswer((_) => aInternetFuture);

      final resultat = informationsReseauInternet.aInternet;

      verify(verificateurDonneesInternet.hasConnection);
      expect(resultat, equals(aInternetFuture));
    });
  });
}
