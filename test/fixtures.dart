import 'dart:io';

String fixture(String nom) => File('test/fixtures/$nom').readAsStringSync();
