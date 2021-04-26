import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/bloc/provider.dart';

import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';
import 'src/pages/anuncio_page.dart';

import 'src/pages/registro_page.dart';
import 'src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    //print(prefs.token);
    //print(prefs.email);
    var iRoute = 'login';
    if (prefs.token != '') {
      iRoute = 'home';
    }

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: iRoute,
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
        ),
      ),
    );
  }
}
