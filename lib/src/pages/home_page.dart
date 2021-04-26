import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_care/src/bloc/provider.dart';
import 'package:pet_care/src/pages/DetallesAnuncio.dart';
import 'package:pet_care/src/providers/usuario_provider.dart';
import 'package:pet_care/src/utils/utils.dart';
import 'package:pet_care/src/models/anuncio_model.dart';
import 'package:pet_care/src/providers/anuncios_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import 'package:pet_care/src/pages/CrearAnuncio.dart';
import 'package:pet_care/src/pages/MisMascotas.dart';




class HomePage extends StatefulWidget {
  final anunciosProvider=0;// = new ProductosProvider();
  final _prefs = 0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final anunciosProvider = new AnunciosProvider();
  final _prefs = new PreferenciasUsuario();
  Future<List<AnuncioModel>> futureAnuncios;
  int _currentIndex = 0;
  Timer _timer;
  static const int periodeRefresh = 2;
  final List<Widget> _children =[];
  final usuarioProvider = new UsuarioProvider();
  @override
  void initState() {
    super.initState();


     usuarioProvider.refreshToken(_prefs.getrefreshtoken);
     futureAnuncios = anunciosProvider.cargarAnuncios();


    _activateTimer();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context).loginBloc;

    return Scaffold(
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
                _refresh();
              }
              ,),
          ),
        ],
      ),
      body: _crearListado(context),


      drawer:
      new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(_prefs.displayName,
                style: TextStyle(color: Colors.lightGreen)),
            accountEmail:
            Text(_prefs.email, style: TextStyle(color: Colors.lightGreen)),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://down-yuantu.pngtree.com/58pic/34/35/46/auto_63558PICtMGS5xycfcCDb_PIC2018.jpg?e=1616157237&st=Y2E5ZjFmYjY3Y2MwMmIwMjdiMTI4NzM1NDMwM2NhNzk&n=%E2%80%94Pngtree%E2%80%94cute+wind+single+dog+background_1145665.jpg"),
                    fit: BoxFit.cover)),
          ),
          Ink(
            color: Colors.lightGreen,
            child: new ListTile(
              title: Text(
                "MENU 1",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _timer.cancel();
              },
            ),
          ),
          new ListTile(
            title: Text("MENU 2"),
            onTap: () {
              _timer.cancel();
            },
          ),
          new ListTile(
            title: Text("Mis Mascotas"),
            onTap: () {
              _timer.cancel();
              _navigateMisMascotas();
            }
          ),
          new ListTile(
            title: Text("CERRAR SESION"),
            onTap: () {
              final _prefs = new PreferenciasUsuario();
              _prefs.token = '';
              _prefs.email = '';
              Navigator.pushNamed(context, 'login');
            },
          )
        ],
      ),
    ),
      floatingActionButton: _crearBoton(context),
      bottomNavigationBar: crearBottomNavigationBar(context),
    );
  }


  _crearListado(BuildContext context) {
    return FutureBuilder(
      future: futureAnuncios,
      builder:
          (BuildContext context, AsyncSnapshot<List<AnuncioModel>> snapshot) {
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
  void _refresh() async {
    futureAnuncios = anunciosProvider.cargarAnuncios();
    setState(() {});
  }
  void _activateTimer() {
    _timer = Timer.periodic(Duration(seconds: periodeRefresh), (Timer t) {
      futureAnuncios = anunciosProvider.cargarAnuncios();
      setState(() {});
    });
  }
  Widget _crearItem(BuildContext context, AnuncioModel producto) {
    return GestureDetector(
      key: UniqueKey(),
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

                  ))
          ),
      onTap: () {
        _navigateDetallesAnuncio(producto.id);
      },
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
        onPressed: ()  { _navigateCrearAnuncio(); _activateTimer();});
  }
  void _navigateCrearAnuncio(){
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
      builder: (context) => CrearAnuncio(),
    )).then( (var value) {
      _activateTimer();
      _refresh();
    });
  }
  void _navigateMisMascotas(){
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
      builder: (context) => MisMascotas(),
    )).then( (var value) {
      _activateTimer();
      _refresh();
    });
  }
  void _navigateDetallesAnuncio(String id){
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
      builder: (context) => DetallesAnuncio(),
    )).then( (var value) {
      _activateTimer();
      _refresh();
    });
  }
}
