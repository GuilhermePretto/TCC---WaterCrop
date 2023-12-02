import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watercrop_app/model/talhao.dart';

import '../model/fazenda.dart';
import '../widgets/navigation_widget.dart';
import '../widgets/talhao_widget.dart';

class TalhaoPage extends StatefulWidget {
  final Fazenda fazenda;
  const TalhaoPage({Key? key, required this.fazenda}) : super(key: key);

  @override
  State<TalhaoPage> createState() => _TalhaoPageState();
}

Stream<QuerySnapshot> getTalhaoData(String fazendaId) {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final fazendaCollectionRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('fazendas')
        .doc(fazendaId)
        .collection('talhoes');
    return fazendaCollectionRef.snapshots();
  } else {
    return const Stream.empty();
  }
}

class _TalhaoPageState extends State<TalhaoPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getTalhaoData(widget.fazenda.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Documentos do usuário não encontrado.');
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Talhão'),
              surfaceTintColor: Colors.grey.shade900,
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            drawer: const Navigation(),
            body: !snapshot.data!.docs.isEmpty
                ? ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          Talhao talhao = Talhao(
                              uid: document.id,
                              fazendaId: widget.fazenda.uid,
                              name: data['nome'].toString(),
                              area: data['area'],
                              lat: double.parse(data['lat'].toString()),
                              long: double.parse(data['long'].toString()));
                          return TalhaoCard(talhao: talhao);
                        })
                        .toList()
                        .cast())
                : Center(
                    child: const Text(
                        'Esta fazenda não possui nenhum talhão cadastrado')),
          );
        });
  }
}
