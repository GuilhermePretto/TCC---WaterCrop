import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watercrop_app/model/fazenda.dart';
import 'package:watercrop_app/widgets/fazenda_widget.dart';

import '../streams/streams.dart';
import '../widgets/navigation_widget.dart';

class FazendaPage extends StatefulWidget {
  const FazendaPage({super.key});

  @override
  State<FazendaPage> createState() => _FazendaPageState();
}

class _FazendaPageState extends State<FazendaPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Streams().getFazendaData,
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
              title: const Text('Fazendas'),
              surfaceTintColor: Colors.grey.shade900,
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            drawer: const Navigation(),
            body: ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      Fazenda fazenda = Fazenda(
                          uid: document.id,
                          name: data['nome'],
                          cep: data['cep'],
                          numero: 0,
                          cidade: data['cidade'],
                          rua: data['rua'],
                          bairro: data['bairro'],
                          area: data['area']);
                      return FazendaCard(fazenda: fazenda);
                    })
                    .toList()
                    .cast()),
          );
        });
  }
}
