import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watercrop_app/pages/cliente_page.dart';
import 'package:watercrop_app/pages/fazenda_page.dart';
import 'package:watercrop_app/pages/sobre_page.dart';

import '../service/auth_service.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationState();

}

class _NavigationState extends State<Navigation> {

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        children: <Widget>[
          const SizedBox(
            height: 64.0,
            child: DrawerHeader(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(15.0),
              child: Text('WATER CROP'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Opções',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.home),
          //   title: const Text(
          //     'Home',
          //     style: TextStyle(fontFamily: 'Roboto'),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (_) => const homePage(),
          //         ));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text(
              'Fazendas',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FazendaPage(),
                  ));
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ListTile(
            leading: Icon(Icons.lens),
            title: const Text(
              'Sobre',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SobrePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text(
              'Perfil',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientePage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: const Text(
              'Sair',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            onTap: () {
              context.read<AuthService>().logout();
              Navigator.of(context).pushReplacementNamed('/auth');
            },
          )
        ],
      );
  }
}