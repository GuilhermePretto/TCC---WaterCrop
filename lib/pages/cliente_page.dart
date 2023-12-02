import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watercrop_app/model/client.dart';
import 'package:watercrop_app/widgets/navigation_widget.dart';

import '../streams/streams.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<StatefulWidget> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var client =
        Client(uid: user!.uid, name: '', email: '', cpf: '', phone: '');

    return StreamBuilder<DocumentSnapshot>(
        stream: Streams().getUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Documento do usuário não encontrado.');
          }

          final userData = snapshot.data;

          client.name = userData?['nome'];
          client.email = userData?['email'];
          client.cpf = userData?['cpf'];
          client.phone = userData?['telefone'];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Perfil'),
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
              children: [
                buildName(client),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            'assets/app/3d_avatar_3.png',
                            //height: MediaQuery.of(context).size.height,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'Email: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                client.email,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'CPF: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                client.cpf,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'Telefone: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                client.phone,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget buildName(Client user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );
}
