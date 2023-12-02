import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/client.dart';
import '../widgets/navigation_widget.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  final Client client;

  const EditProfilePage({Key? key, required this.client}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  late final TextEditingController nameToSave = TextEditingController();
  late final TextEditingController emailToSave = TextEditingController();
  late final TextEditingController cpfToSave = TextEditingController();

  saveData() {
    final userDataSave = <String, String>{
      "nome": nameToSave.text,
      "email": emailToSave.text,
      "cpf": cpfToSave.text
    };
    FirebaseFirestore.instance.collection('usuarios').doc(user?.uid).set(userDataSave);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Dados salvos com sucesso'),
      backgroundColor: Colors.green,
    ));
    Navigator.of(context).pushReplacementNamed('/perfil');
  }

  @override
  Widget build(BuildContext context) {
    nameToSave.text = widget.client.name;
    emailToSave.text = widget.client.email;
    cpfToSave.text = widget.client.cpf;
    
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: nameToSave,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailToSave,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cpfToSave,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                saveData();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Salvar',
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
