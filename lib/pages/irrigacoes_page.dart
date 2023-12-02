import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watercrop_app/model/irrigacao.dart';
import 'package:watercrop_app/widgets/irrigacao_widget.dart';

import '../model/safra.dart';
import '../model/talhao.dart';
import '../widgets/navigation_widget.dart';

class IrrigacoesPage extends StatefulWidget {
  final Safra safra;
  final Talhao talhao;
  const IrrigacoesPage({Key? key, required this.safra, required this.talhao})
      : super(key: key);

  @override
  State<IrrigacoesPage> createState() => _IrrigacoesPageState();
}

Stream<QuerySnapshot> getIrrigacaoData(
    String fazendaId, String talhaoId, String safraId) {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final irrigacaoCollectionRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('fazendas')
        .doc(fazendaId)
        .collection('talhoes')
        .doc(talhaoId)
        .collection('safras')
        .doc(safraId)
        .collection('irrigacoes');
    return irrigacaoCollectionRef.snapshots();
  } else {
    return const Stream.empty();
  }
}

class _IrrigacoesPageState extends State<IrrigacoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigações'),
        surfaceTintColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      drawer: const Navigation(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Safra: "+widget.safra.cultura + ' '+widget.safra.ano.toString(), style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Cultivar: '+widget.safra.cultivar, style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: widget.safra.irrigation!.isNotEmpty
                ? ListView(
                    children: widget.safra.irrigation!.asMap().entries
                        .map((item) {
                          Irrigacao irrigacao = Irrigacao(
                              data: item.value['day_of_year'],
                              irrigacao: item.value['irrigation'],
                              deficit: item.value['deficit'],
                              rain: item.value['rain'],
                              irrigated: item.value['irrigated'] != null
                                  ? item.value['irrigated']
                                  : false,
                              position: item.key,
                              available_water: item.value['available_water']);
                          return IrrigacaoCard(
                            irrigacao: irrigacao,
                            talhao: widget.talhao,
                            safra: widget.safra,
                          );
                        })
                        .toList()
                        .cast())
                : const Center(
                    child:
                        Text('Este talhão não possui nenhuma irrigação cadastrada')),
          ),
        ],
      ),
    );
  }
}
