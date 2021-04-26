import 'package:flutter/material.dart';
import 'package:pet_care/src/bloc/provider.dart';
import 'package:pet_care/src/providers/usuario_provider.dart';
import 'package:pet_care/src/utils/utils.dart';


class registroPerf extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ));
  }




  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context).loginBloc;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                  height: 180.0,
                ),
              ),
              Container(
                width: size.width * 0.85,
                margin: EdgeInsets.symmetric(vertical: 30.0),
                padding: EdgeInsets.symmetric(vertical: 50.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: 3.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Text('Creación Perfil', style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 60.0),
                    _crearNombre(bloc),
                    SizedBox(height: 30.0),
                    _crearApellido(bloc),
                    SizedBox(height: 30.0),
                    _crearDireccion(bloc),
                    SizedBox(height: 30.0),
                    _crearCiudad(bloc),
                    SizedBox(height: 30.0),
                    _crearCodigoPostal(bloc),
                    SizedBox(height: 30.0),
                    _crearBoton(bloc),

                  ],
                ),
              )]
        ));
  }


  Widget _crearNombre(LoginBloc bloc) {
    return StreamBuilder(

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'John',
                labelText: 'Nombre',
                counterText: snapshot.data,
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget _crearApellido(LoginBloc bloc) {
    return StreamBuilder(

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Doe',
                labelText: 'Apellidos',
                counterText: snapshot.data,
                errorText: snapshot.error),
          ),
        );
      },
    );
  }


  Widget _crearDireccion(LoginBloc bloc) {
    return StreamBuilder(

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
                hintText: 'C/ de Mallorca, 401',
                labelText: 'Dirección',
                counterText: snapshot.data,
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget _crearCiudad(LoginBloc bloc) {
    return StreamBuilder(

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Barcelona',
                labelText: 'Ciudad',
                counterText: snapshot.data,
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget _crearCodigoPostal(LoginBloc bloc) {
    return StreamBuilder(

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 5,
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                ),
                hintText: '',
                labelText: 'Código postal',
                counterText: snapshot.data,
                errorText: snapshot.error),
          ),

        );
      },
    );
  }





  Widget _crearBoton(LoginBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Finalizar registro'),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.lightGreen,
          textColor: Colors.white,
        );
      },
    );
  }



  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('PetCare',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}