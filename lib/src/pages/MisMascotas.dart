import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/src/pages/CrearMascota.dart';
import 'package:pet_care/src/models/addmascota_model.dart';
import 'package:pet_care/src/providers/addmascota_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../preferencias_usuario/preferencias_usuario.dart' as user;


import 'home_page.dart';

class MisMascotas extends StatefulWidget{
  final mascotasProvider=0;// = new ProductosProvider();
  final _prefs = 0;
  @override
  _MisMascotas createState() => _MisMascotas();

}

class _MisMascotas extends State<MisMascotas> {
  user.PreferenciasUsuario datosUser = user.PreferenciasUsuario();
  final mascotasProvider = new AddMascotaProvider();
  final _prefs = new user.PreferenciasUsuario();
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
              padding: const EdgeInsets.all(8.0), child: Text('Mis Mascotas' , style: TextStyle(
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
      body:
        _crearListado(context),
        floatingActionButton: Container(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            onPressed: () {
              _navigateCrearMascota();
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 40),
            ),
          ),
        )
    );
  }
  _crearListado(BuildContext context) {
    user.PreferenciasUsuario datosUser = user.PreferenciasUsuario();
    return FutureBuilder(
      future: mascotasProvider.cargarMascotas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<AddMascotaModel>> snapshot) {
        if (snapshot.hasData) {
          final anuncios = snapshot.data;
          return ListView.builder(
            itemCount: anuncios.length,
            itemBuilder: (context, i) => _crearItem(context, anuncios[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, AddMascotaModel producto) {
    if(producto.id==datosUser.email){
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          //mascotasProvider.eliminarProducto(producto.id);
        },
        child:
        Container(
            padding: const EdgeInsets.all(5.0),
            child:Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    color: Colors.lightGreen,
                  ),
                  borderRadius: BorderRadius.circular(10.0),

                ),
                child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4.0)
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              padding:const EdgeInsets.symmetric(vertical: 12.0),
                              child:Image.asset(
                                'assets/icon/icon.png',
                                fit: BoxFit.fill,
                                height: 60,
                                width: 60,
                              )
                          ),
                        ],
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(12.0)
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child:Text('${producto.nombre}',
                                  style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Padding(
                                padding: const EdgeInsets.all(1.0)
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child:Text('${producto.descripcion}')
                            ),
                            Padding(
                                padding: const EdgeInsets.all(1.0)
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child:Text('${producto.observaciones}', overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontStyle: FontStyle.italic),)
                            ),
                            Padding(
                                padding: const EdgeInsets.all(12.0)
                            ),
                          ],
                        ),
                      )
                    ]
                  /*
                    leading: Icon(Icons.perm_identity),
                    title: Text('${producto.nombre}'),
                    trailing: Text('${producto.descripcion}'),
                    subtitle: Text('${producto.observaciones}'),
                    onTap: () =>  Navigator.pushNamed(context, 'producto', arguments: producto),
                    */
                ))
        ),
      );
    }

  }
  void _navigateCrearMascota(){
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
      builder: (context) => CrearMascota(),
    )).then( (var value) {
    });
  }
}
