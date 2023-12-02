import 'package:flutter/material.dart';
import 'package:watercrop_app/pages/safras_page.dart';

import '../model/talhao.dart';

class TalhaoCard extends StatelessWidget {
  final Talhao talhao;

  const TalhaoCard({Key? key, required this.talhao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.filter_hdr_rounded),
              title: Text(talhao.name),
              subtitle: Text(talhao.area.toString()),
              trailing: IconButton(
                icon: Icon(Icons.info), 
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 180,
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
                                      child: Text('Talhão '+ talhao.name, style: TextStyle(fontSize: 16),),
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
                                      Text('Latitude: ', style: TextStyle(fontSize: 16),),
                                      Text(talhao.lat.toString(), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Longitude: ', style: TextStyle(fontSize: 16),),
                                      Text(talhao.long.toString(), style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Área (ha): ', style: TextStyle(fontSize: 16),),
                                      Text(talhao.area.toString(), style: TextStyle(fontSize: 16),),
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
                    builder: (context) => SafrasPage(talhao: talhao)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}