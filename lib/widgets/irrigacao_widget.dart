import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watercrop_app/model/irrigacao.dart';

import '../model/safra.dart';
import '../model/talhao.dart';

class IrrigacaoCard extends StatefulWidget {
  final Irrigacao irrigacao;
  final Talhao talhao;
  final Safra safra;
  const IrrigacaoCard(
      {Key? key,
      required this.irrigacao,
      required this.talhao,
      required this.safra})
      : super(key: key);

  @override
  State<IrrigacaoCard> createState() => _IrrigacaoCardState();
}

Stream<DocumentSnapshot> getSafraData(
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
        .doc(safraId);
    return irrigacaoCollectionRef.snapshots();
  } else {
    return const Stream.empty();
  }
}

class _IrrigacaoCardState extends State<IrrigacaoCard> {
  final user = FirebaseAuth.instance.currentUser;
  late final TextEditingController rain = TextEditingController();

  saveData() {
    final List teste = widget.safra.irrigation!;
    teste[widget.irrigacao.position]['irrigated'] = widget.irrigacao.irrigated;
    final userDataSave = <String, dynamic>{
      'irrigation': teste,
    };
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user?.uid)
        .collection('fazendas')
        .doc(widget.talhao.fazendaId)
        .collection('talhoes')
        .doc(widget.talhao.uid)
        .collection('safras')
        .doc(widget.safra.uid)
        .update(userDataSave);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Dados salvos com sucesso'),
      backgroundColor: Colors.green,
    ));
    Navigator.pop(context);

  }

  saveDataRain() {
    final List dados_meteorologicos = widget.safra.dados_meteorologicos!;
    dados_meteorologicos[widget.irrigacao.position +
        (dados_meteorologicos.length - 1) -
        (widget.irrigacao.position * 2)]['rain'] = int.parse(rain.text);
    final userDataSave = <String, dynamic>{
      'dados_meteorologicos': dados_meteorologicos,
    };
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user?.uid)
        .collection('fazendas')
        .doc(widget.talhao.fazendaId)
        .collection('talhoes')
        .doc(widget.talhao.uid)
        .collection('safras')
        .doc(widget.safra.uid)
        .update(userDataSave);

    final List irrigacoes = widget.safra.irrigation!;
    irrigacoes[widget.irrigacao.position]['rain'] = int.parse(rain.text);
    final irrigacaoDataSave = <String, dynamic>{
      'irrigation': irrigacoes,
    };
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user?.uid)
        .collection('fazendas')
        .doc(widget.talhao.fazendaId)
        .collection('talhoes')
        .doc(widget.talhao.uid)
        .collection('safras')
        .doc(widget.safra.uid)
        .update(irrigacaoDataSave);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Dados salvos com sucesso'),
      backgroundColor: Colors.green,
    ));
    Navigator.pop(context);
  }

  abrirModal() {
    final Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 10,
          horizontal: MediaQuery.of(context).size.width / 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Editar chuva',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
              child: TextField(
                controller: rain,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Chuva',
                    labelStyle: TextStyle(fontSize: 20)),
                keyboardType: TextInputType.number,
                maxLines: 1,
              ),
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              style: ButtonStyle(),
              onPressed: () => saveDataRain(),
            ),
          ]),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  modalConfirmaIrrigacao(bool confirmacao) {
    final Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 2.5,
          horizontal: MediaQuery.of(context).size.width / 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: confirmacao
                    ? const Text(
                        'Deseja realmente confirmar essa irrigação?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        'Deseja realmente descartar essa irrigação?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('Sim'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    elevation: 0,
                  ),
                  onPressed: () =>
                      {widget.irrigacao.irrigated = confirmacao, saveData()},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent.shade100,
                    elevation: 0,
                  ),
                  child: const Text('Não'),
                  onPressed: () => {Navigator.pop(context)},
                ),
              ],
            ),
          ]),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    rain.text =
        widget.safra.irrigation![widget.irrigacao.position]['rain'].toString();
    return StreamBuilder<DocumentSnapshot>(
        stream: getSafraData(
            widget.talhao.fazendaId, widget.talhao.uid, widget.safra.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Documentos do usuário não encontrado.');
          }
          Map<String, dynamic> data =
              snapshot.data!.data()! as Map<String, dynamic>;
          Map<String, dynamic> irriga = data['irrigation']
              [widget.irrigacao.position] as Map<String, dynamic>;
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                            selected: DateTime.now()
                                            .difference(new DateTime(
                                              2023,
                                              1,
                                              1,
                                            ))
                                            .inDays +
                                        1 ==
                                    irriga['day_of_year']
                                ? true
                                : false,
                            title: Text(
                                DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        irriga['day_of_year'])),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              'Chuva: ' +
                                  irriga['rain'].toStringAsFixed(0) +
                                  'mm   Irrigação: ' +
                                  irriga['irrigation'].toStringAsFixed(0) +
                                  'mm',
                            ),
                            onTap: () {},
                            trailing: irriga['irrigation'] > 0
                                ? IconButton(
                                    icon: irriga['irrigated']!
                                        ? Icon(Icons.check_box,
                                            color: Colors.green)
                                        : Icon(
                                            Icons.help_center_outlined,
                                            color: const Color.fromARGB(
                                                255, 225, 149, 33),
                                          ),
                                    onPressed: () => {
                                          modalConfirmaIrrigacao(
                                              !irriga['irrigated']!),
                                        })
                                : null),
                      ),
                      IconButton(
                          onPressed: () => {
                                abrirModal(),
                              },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  DateTime calcularDataDoDiaDoAno(int numeroDoDiaDoAno) {
    DateTime primeiroDiaDoAno = DateTime(2023, 1, 1);
    Duration duracao =
        Duration(days: numeroDoDiaDoAno - 1); // -1 porque os dias começam de 1

    return primeiroDiaDoAno.add(duracao);
  }
}
