import 'package:flutter/material.dart';
import 'package:watercrop_app/model/fazenda.dart';
import 'package:watercrop_app/pages/talhao_page.dart';

class FazendaCard extends StatelessWidget {
  final Fazenda fazenda;

  const FazendaCard({Key? key, required this.fazenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text(fazenda.name),
              subtitle: Text(fazenda.cidade),
              trailing: IconButton(
                  icon: Icon(Icons.info), 
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 230,
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
                                        child: Text('Fazenda '+ fazenda.name, style: TextStyle(fontSize: 16),),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('CEP: ', style: TextStyle(fontSize: 16),),
                                        Text(fazenda.cep.toString(), style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Cidade: ', style: TextStyle(fontSize: 16),),
                                        Text(fazenda.cidade, style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Rua: ', style: TextStyle(fontSize: 16),),
                                        Text(fazenda.rua, style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Bairro: ', style: TextStyle(fontSize: 16),),
                                        Text(fazenda.bairro, style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Numero: ', style: TextStyle(fontSize: 16),),
                                        Text(fazenda.numero.toString(), style: TextStyle(fontSize: 16),),
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
                    builder: (context) => TalhaoPage(fazenda: fazenda)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
