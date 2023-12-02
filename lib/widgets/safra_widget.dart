import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watercrop_app/model/safra.dart';
import 'package:watercrop_app/model/talhao.dart';
import '../pages/irrigacoes_page.dart';

class SafraCard extends StatelessWidget {
  final Safra safra;
  final Talhao talhao;
  const SafraCard({Key? key, required this.safra, required this.talhao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.grass),
              title: Text(safra.ano.toString() +' - '+safra.cultura.toString()),
              subtitle: Text('Cultivar: '+safra.cultivar.toString()),
              trailing: IconButton(
                icon: Icon(Icons.info), 
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('Safra '+ safra.ano.toString(), style: TextStyle(fontSize: 16),),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cultura: ', style: TextStyle(fontSize: 16),),
                                      Text(safra.cultura, style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cultivar: ', style: TextStyle(fontSize: 16),),
                                      Text(safra.cultivar, style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Semeadura: ', style: TextStyle(fontSize: 16),),
                                      Text(DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        safra.sow_day)), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('4 Folhas: ', style: TextStyle(fontSize: 16),),
                                      Text(DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        safra.sow_day+safra.vget4_day)), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Florescimento: ', style: TextStyle(fontSize: 16),),
                                      Text(DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        safra.sow_day+safra.flower_day)), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Enchimento De Grão: ', style: TextStyle(fontSize: 16),),
                                      Text(DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        safra.sow_day+safra.grain_fill_day)), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Maturação: ', style: TextStyle(fontSize: 16),),
                                      Text(DateFormat('dd/MM/yyyy').format(
                                    calcularDataDoDiaDoAno(
                                        safra.sow_day+safra.matur_day)), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Capacidade Do Pivo (ml): ', style: TextStyle(fontSize: 16),),
                                      Text(safra.pivot_cap.toString(), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => IrrigacoesPage(
                            safra: safra,
                            talhao: talhao,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DateTime calcularDataDoDiaDoAno(int numeroDoDiaDoAno) {
    DateTime primeiroDiaDoAno = DateTime(2023, 1, 1);
    Duration duracao =
        Duration(days: numeroDoDiaDoAno - 1); // -1 porque os dias começam de 1

    return primeiroDiaDoAno.add(duracao);
  }
}
