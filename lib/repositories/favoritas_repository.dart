import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_firestore.dart';
import 'package:flutter_application_1/repositories/roupa_repository.dart';
import 'package:flutter_application_1/services/auth_service.dart';

import '../models/roupa.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Roupa> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  FavoritasRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await startFirestore();
    await _readFavoritas();
  }

  startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritas() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/favoritas').get();
      snapshot.docs.forEach((doc) {
        Roupa roupa = RoupaRepository.tabela
            .firstWhere((roupa) => roupa.marca == doc.get('marca'));
        _lista.add(roupa);
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Roupa> get lista => UnmodifiableListView(_lista);

  saveAll(List<Roupa> roupas) {
    roupas.forEach((roupa) async {
      if (!_lista.any((atual) => atual.marca == roupa.marca)) {
        _lista.add(roupa);
        await db
            .collection('usuarios/{$auth.usuario!.uid}/favoritas')
            .doc(roupa.marca)
            .set({
          'cor': roupa.cor,
          'tamanho': roupa.tamanho,
          'marca': roupa.marca,
          'tipo': roupa.tipo,
        });
      }
    });
    notifyListeners();
  }

  remove(Roupa roupa) async {
    await db
        .collection('usuarios/{$auth.usuario!.uid}/favoritas')
        .doc(roupa.marca)
        .delete();

    _lista.remove(roupa);
    notifyListeners();
  }
}
