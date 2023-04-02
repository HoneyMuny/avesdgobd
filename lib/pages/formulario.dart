import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../clases/datos.dart';
import '../menus/inicio.dart';

class Formulario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MiFormulario();
  }
}

class MiFormulario extends State<Formulario>{
  final controladornc = TextEditingController();
  final controladorncc = TextEditingController();
  final controladorncr = TextEditingController();
  Datos? dat= Datos("", "", "", "");
  Future<void>guardarDatos(String nombre, String nombrecie, String nombrecr, String foto) async {
    Future.delayed(Duration(seconds: 7), () async {
      final datos = await FirebaseFirestore.instance.collection('avesdgo');
      return datos.add({
        'nombrecom':nombre,
        'nombrecien':nombrecie,
        'credencial':nombrecr,
        'foto':foto
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de la Ave'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: controladornc,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Común'
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: controladorncc,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Cientifico'
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: controladorncr,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Créditos'
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                onPressed: (){
                  dat!.nombrecom = controladornc.text;
                  dat!.nombrecien = controladorncr.text;
                  dat!.credencial = controladorncr.text;
                  dat!.foto = Datos.downloadURL;
                  guardarDatos(dat!.nombrecom, dat!.nombrecien, dat!.credencial, dat!.foto);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => Inicio() ),
                      ModalRoute.withName('/')
                  );
                },
                child: Text('Registrar'),
              )
            ],
          ),
        ),
      ),

    );
  }

}