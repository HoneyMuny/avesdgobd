import 'package:avesdgobd/pages/listadatos.dart';
import 'package:avesdgobd/pages/splashscreen.dart';
import 'package:flutter/material.dart';

import '../pages/fotos.dart';

class Inicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MiInicio();
  }
}

class MiInicio extends State<Inicio>{
  int _selectIndex = 0;
  final List<Widget> _children= [
    ListaDatos(),
    Fotos()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children[_selectIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.blueGrey,
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Camara'
          )
        ],
      ),
    );
  }

}