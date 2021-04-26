

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/src/models/addmascota_model.dart';
import 'package:pet_care/src/models/anuncio_model.dart';
import 'package:pet_care/src/providers/addmascota_provider.dart';
import 'package:pet_care/src/providers/anuncios_provider.dart';
import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart'as user;

import 'home_page.dart';

class CrearAnuncio extends StatefulWidget{
  @override
  _CrearAnuncio createState() => _CrearAnuncio();

}

class _CrearAnuncio extends State<CrearAnuncio> {

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
                padding: const EdgeInsets.all(8.0), child: Text('Crear Anuncio' , style: TextStyle(
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
              onPressed: () {
                while (Navigator.of(context).canPop()) {
                  print("pop");
                  Navigator.of(context).pop();
                }
                HomePage();
              }
              ,),
          ),


        ],

      ),
      body: SafeArea(
          child: CargaAnuncio()),
    );
  }
}

class CargaAnuncio extends StatefulWidget{
  CargaAnuncio();
  @override
  CargaAnuncioState createState() => CargaAnuncioState();
}

class CargaAnuncioState extends State<CargaAnuncio>{
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final addAnuncioProvider = new AnunciosProvider();
  AnuncioModel addAnuncio = new AnuncioModel();
  bool _guardando = false;
  TextEditingController NombreMascota = TextEditingController();
  TextEditingController DescripcionMascota = TextEditingController();
  TextEditingController ObservMascota = TextEditingController();

  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      key: formKey,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child:Container(
            margin: const EdgeInsets.only(left: 50.0, right: 0.0),
            child:
          Text(
            ('¿Tiene una mascota registrada?'),
            style: DefaultTextStyle
                .of(context)
                .style
                .apply(fontSizeFactor: 1),
          ),),

        ),
        Container(
            width:300,
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10)
          ),
          child:Center(   child:
          DropdownButton(
            hint: Container(
              width: 230,
              child:Center(child:Text('Seleccione su mascota'),)
            ),
          ))
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child:Container(
            margin: const EdgeInsets.only(left: 50.0, right: 0.0),
            child:
            Text(
              ('Nombre:'),
              style: DefaultTextStyle
                  .of(context)
                  .style
                  .apply(fontSizeFactor: 1),
            ),),

        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10)
          ),
          child:Container(
            width: 300,
            child:
              TextFormField(
                initialValue: addAnuncio.nombre,
                onChanged: (value) => addAnuncio.nombre = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Introduzca el nombre de la mascota';
                    }return null;}
              ))
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child:Container(
            margin: const EdgeInsets.only(left: 50.0, right: 0.0),
            child:
            Text(
              ('Descripción:'),
              style: DefaultTextStyle
                  .of(context)
                  .style
                  .apply(fontSizeFactor: 1),
            ),),

        ),
        Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10)
            ),
            child:Container(
                width: 300,
                child:
                TextFormField(
                  maxLines:null,
                  textInputAction: TextInputAction.done,
                    initialValue: addAnuncio.descripcion,
                    onChanged: (value) => addAnuncio.descripcion = value,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Introduzca la descripción de la mascota';
                      }return null;}
                ))
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child:Container(
            margin: const EdgeInsets.only(left: 50.0, right: 0.0),
            child:
            Text(
              ('Observaciones y cuidados:'),
              style: DefaultTextStyle
                  .of(context)
                  .style
                  .apply(fontSizeFactor: 1),
            ),),

        ),
        Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10)
            ),
            child:Container(
                width: 300,
                child:
                TextFormField(
                  maxLines:null,
                  textInputAction: TextInputAction.done,
                    initialValue: addAnuncio.observaciones,
                    onChanged: (value) => addAnuncio.observaciones = value,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Introduzca el nombre de la mascota';
                      }return null;}
                ))
        ),
        Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0)
            ),
            Container(
              width: 130,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: FlatButton(
                    onPressed: (_guardando) ? null : _submit,
                  child: Text(
                    ('Subir'),
                  ),
                  textColor: Colors.white,
                )
            )
          ],
        )
      ],
    );

  }
  void _submit() {
    user.PreferenciasUsuario datosUser = user.PreferenciasUsuario();
    addAnuncio.id=datosUser.email;
    addAnuncioProvider.crearAnuncio(addAnuncio);
    setState(() {
      _guardando = true;
    });
    Navigator.pop(context);
  }
}