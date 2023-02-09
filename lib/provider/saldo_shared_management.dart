import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class SaldoState with ChangeNotifier {
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamSaldo() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection('users').doc(uid).snapshots();
  }

  int _saldo = 0;

  int get getSaldo {
    return _saldo;
  }

  void tambahSaldo(int cost) {
    _saldo += cost;
    notifyListeners();
  }
}
