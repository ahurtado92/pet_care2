import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/src/models/anuncio_model.dart';
import 'package:pet_care/src/providers/anuncios_provider.dart';
import 'package:pet_care/src/utils/utils.dart' as utils;

import 'home_page.dart';

class DetallesAnuncio extends StatefulWidget{
  @override
  _DetallesAnuncio createState() => _DetallesAnuncio();
}

class _DetallesAnuncio extends State<DetallesAnuncio> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new AnunciosProvider();
  AnuncioModel producto = new AnuncioModel();
  Future<AnuncioModel> DAnuncio;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0), child: Text('Detalles Anuncio' , style: TextStyle(
                color: Colors.white
            ),), ),
          ],
        ),
        actions: <Widget>[
          Container(
            width: 50,
            child:
            IconButton(icon:Image.asset(
              'assets/Blanco.png',
              fit: BoxFit.contain,
              height: 50,
              ),
            ),
          ),
        ],
      ),
      //body: _mostrarDetalles(context),
        body: Center(
          child: Container(
              padding: EdgeInsets.only(
                left: 10,
                top: 30,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/icon/icon.png',
                            fit: BoxFit.fill,
                            height: 120,
                            width: 120,
                          )
                        ],
                      ),
                          Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                            constraints: BoxConstraints(
                              maxWidth: 260,
                            ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nombre: '),
                                  Text('Tipo: '),
                                  Text('Observaciones: ')
                                ],
                              )
                          ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 30,
                        right: 10,
                        bottom: 30,
                      ),
                    child: Column(
                      children: [
                        Text('Descripcion: ')
                      ],
                  )),
                ]
              )
          ),
        )
    );
  }


  /*
  _mostrarDetalles(BuildContext context) {
    return FutureBuilder(
      future: DAnuncio,
      builder: (BuildContext context, AsyncSnapshot<AnuncioModel> snapshot) {
        if (snapshot.hasData) {
          final anuncio = snapshot.data;
          return builde
        }
      },
    );
  }



  Widget _Detalles2(BuildContext context, AnuncioModel producto) {
    return Column(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 50.0, right: 50.0),
              child:Text('${producto.nombre}',
                style: TextStyle(fontWeight: FontWeight.bold),)
          ),
        ),
        Container(

        )
      ],
    );
  }
  */
  Widget _Detalles2(BuildContext context, AnuncioModel producto) {
    return Column(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              padding:const EdgeInsets.symmetric(vertical: 12.0),
              child:Image.asset('assets/icon/icon.png',
                fit: BoxFit.fill,
                height: 60,
                width: 60,
              )
            ),
          ],),
        ),
      ],
    );
  }

}
