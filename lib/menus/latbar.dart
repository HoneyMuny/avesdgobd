import 'package:avesdgobd/pages/listadatos.dart';
import 'package:flutter/material.dart';
import 'package:avesdgobd/pages/UpdateList.dart';
import 'package:avesdgobd/pages/fotos.dart';
import 'package:avesdgobd/pages/update.dart';
class latbar extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return  Drawer(
        child: ListView(
          children: [
            const DrawerHeader(

              decoration: BoxDecoration(
                  color:Colors.orange,
                  image: DecorationImage(
                      image: AssetImage("images/medium.png"),
                      fit:BoxFit.fitHeight
                  )
              ),
              child: Text(""),
            ),
            Ink(
              child: const ListTile(
                title: Text(
                  "Aves de Durango (o゜▽゜)o☆"),

              ),
            ),
            ListTile(
                title: const Text("Lista de Aves", style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.list_alt_outlined,color: Colors.black,),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)
                      {
                        return ListaDatos();
                      }));
                }),
            ListTile(
                title: const Text("Fotografiar", style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.camera_alt_outlined,color: Colors.black,),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)
                      {
                        return Fotos();
                      }));
                }),
            ListTile(
                title: const Text("Editar", style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.change_circle_outlined,color: Colors.black,),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)
                      {
                        return AnimalListPage();
                      }));
                }),
          ],
        )
    );
  }
}