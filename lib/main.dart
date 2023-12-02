import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watercrop_app/pages/cliente_page.dart';
import 'package:watercrop_app/pages/fazenda_page.dart';
import 'package:watercrop_app/pages/login_page.dart';
import 'package:watercrop_app/pages/sobre_page.dart';
import 'package:watercrop_app/pages/splash_page.dart';
import 'package:watercrop_app/service/auth_service.dart';
import 'package:watercrop_app/widgets/auth_check.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF0062A2), secondary: Color(0xFF0062A2)),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/auth': (_) => const AuthCheck(),
        '/login': (_) => const LoginPage(),
        '/perfil': (_) => const ClientePage(),
        '/fazenda': (_) => const FazendaPage(),
        '/sobre': (_) => const SobrePage(),
      },
      home: const AuthCheck(),
    );
  }
}
