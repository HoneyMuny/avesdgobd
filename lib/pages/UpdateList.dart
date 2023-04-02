import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avesdgobd/pages/update.dart';
import 'package:http/http.dart' as http;

class AnimalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de edición (^・ω・^ )'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('avesdgo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final doc = snapshot.data!.docs[index];

              return GestureDetector(
                onTap: () async {
                  final choice = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿Deseas editar o eliminar la información del ave?', style: TextStyle(color: Colors.black)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Editar');
                            },
                            child: Text('Editar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Eliminar');
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      );
                    },
                  );

                  if (choice == 'Editar') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateAnimalScreen(animalId: doc.id),
                      ),
                    );
                  } else if (choice == 'Eliminar') {
                    await FirebaseFirestore.instance.collection('avesdgo').doc(doc.id).delete();
                    String url= doc['foto'];
                    http.Response response = await http.get(Uri.parse(url));
                    if(response.statusCode==200)
                    {
                      await FirebaseStorage.instance.ref().child(""+
                          doc['foto']).delete();
                    }
                    Navigator.pop(context);
                  }
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(doc['foto']),
                      ListTile(
                        title: Text(doc['nombrecom'], style: TextStyle(color: Colors.deepOrange)),
                        subtitle: Text('Nombre cientifico: '+doc['nombrecien']+"\n"+
                        "Fotografiada por: "+doc['credencial'], style: TextStyle(fontSize: 15, color: Colors.deepOrange)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}