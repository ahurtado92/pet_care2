import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/src/models/addmascota_model.dart';
import 'package:pet_care/src/providers/addmascota_provider.dart';
import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart'as user;

import 'home_page.dart';
import 'MisMascotas.dart';

class CrearMascota extends StatefulWidget{
  @override
  _CrearMascota createState() => _CrearMascota();

}
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class _CrearMascota extends State<CrearMascota> {
  TextEditingController NombreMascota = TextEditingController();
  TextEditingController EdadMascota = TextEditingController();
  TextEditingController DescripcionMascota = TextEditingController();
  TextEditingController ObservMascota = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final addmascotaProvider = new AddMascotaProvider();
  AddMascotaModel addmascota = new AddMascotaModel();
  bool _guardando = false;


  List<ListItem> _dropdownItems = [
    ListItem(1, "Perro"),
    ListItem(2, "Gato"),
    ListItem(3, "Pez"),
    ListItem(4, "Ave"),
    ListItem(5, "Otros")


  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;


  void initState() {
    super.initState();
    GlobalKey<FormState> keyForm= new GlobalKey();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

  }
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: formKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0), child: Text('PetCare' , style: TextStyle(
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
        body: Column(
          children:<Widget> [
            Container(
                child: Text("Registar Mascota",style: TextStyle(fontSize: 32),)
            )
            ,Container(
                child: Text("Nombre:",style: TextStyle(fontSize: 16),)
            ),
            TextFormField(
                initialValue: addmascota.nombre,
                onChanged: (value) => addmascota.nombre = value,
                decoration: InputDecoration(
              ),
          validator: (value) {
            if (value.isEmpty) {
                return 'Enter last Name';
              }return null;}
            ),Container(
              child: Text("Introduce el tipo de animal de tu mascota:",style: TextStyle(fontSize: 16)),
            ),Container(
              child: DropdownButton<ListItem>(
                  value: _selectedItem,items:_dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem=value;
                      String aux=_selectedItem.name.toString();
                      //String aux=_selectedItem.toString();
                      addmascota.tipo = aux;
                    });
                  }
              ),
            ),
            Container(
                child: Text("Edad:",style: TextStyle(fontSize: 16),)

            ),
            TextFormField(
                controller: EdadMascota,
                onChanged: (value) => addmascota.edad = value,
                decoration: InputDecoration(
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter last Name';
                  }return null;}
            ),
            Container(
              child: Text("Descripción:",style: TextStyle(fontSize: 16),)
            ),
            TextFormField(
                controller: DescripcionMascota,
                onChanged: (value) => addmascota.descripcion = DescripcionMascota.text,
                decoration: InputDecoration(
                  //labelText: 'Describe a tu mascota',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter last Name';
                  }return null;}
            ),
            Container(
                child: Text("Observaciones y requisitos:",style: TextStyle(fontSize: 16),)

            ),
            TextFormField(
                controller: ObservMascota,
                onChanged: (value) => addmascota.observaciones = value,
                decoration: InputDecoration(
                  //labelText: 'Introduce observaciones sobre tu mascota',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter last Name';
                  }return null;}
            ),
            new RaisedButton(
              onPressed: (_guardando) ? null : _submit,
              child: new Text('Registrar'),
              color: Colors.lightGreen,
              textColor: Colors.white,
            ),
          ],
        ),
    );
    }

  void _submit() {
    user.PreferenciasUsuario datosUser = user.PreferenciasUsuario();
    addmascota.id=datosUser.email;
    addmascotaProvider.crearAddMascota(addmascota);
    setState(() {
      _guardando = true;
    });
    Navigator.pop(context);
  }
}

