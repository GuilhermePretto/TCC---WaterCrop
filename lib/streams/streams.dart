

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Streams{
  final user = FirebaseAuth.instance.currentUser;

  Stream<DocumentSnapshot> get getUserData {
    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('usuarios').doc(user?.uid);
      return userDocRef.snapshots();
    } else {
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> get getFazendaData {
    if (user != null) {
      final fazendaCollectionRef =
          FirebaseFirestore.instance.collection('usuarios').doc(user?.uid).collection('fazendas');
      return fazendaCollectionRef.snapshots();
    } else {
      return const Stream.empty();
    }
  }

}

