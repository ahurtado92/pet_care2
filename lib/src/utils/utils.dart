import 'package:flutter/material.dart';
import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:pet_care/src/pages/home_page.dart' as home;

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

BottomNavigationBar crearBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: 0, // this will be set when a new tab is tapped
    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.pets),
        title: new Text('Mascotas'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.person),
        title: new Text('Cuidadores'),
      ),
    ],
  );
}


