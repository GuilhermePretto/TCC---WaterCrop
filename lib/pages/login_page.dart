import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watercrop_app/pages/termos_uso.dart';
import 'package:watercrop_app/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  bool checkValue = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        titulo = 'Bem vindo';
        actionButton = 'ENTRAR';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

  login() async {
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Erro no login"),
          content: Text(e.message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Ok"),
              ),
            ),
          ],
        ),
      );
    }
  }

  registrar() async {
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  errorCheckBox() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Aceite os termos para realizar o login')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.only(top: 100),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        // const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                        const EdgeInsets.only(
                            top: 50, left: 60, right: 60, bottom: 12),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 60),
                    child: TextFormField(
                      controller: senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 45.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: checkValue,
                          onChanged: (bool? value) {
                            setState(() {
                              checkValue = !checkValue;
                            });
                          },
                        ),
                        const Text(
                          'Li e concordo com os',
                          style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TermosUso(),
                            )),
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(5)),
                          child: const Text(
                            'termos de uso',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: 'Roboto'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 150.0, horizontal: 100.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            if (checkValue) {
                              login();
                            } else {
                              errorCheckBox();
                            }
                          } else {
                            registrar();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              actionButton,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )]),
        ),
      ),
    );
  }
}
