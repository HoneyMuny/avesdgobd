import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


class UpdateAnimalScreen extends StatefulWidget {
  final String animalId;

  UpdateAnimalScreen({required this.animalId});

  @override
  _UpdateAnimalScreenState createState() => _UpdateAnimalScreenState();
}

class _UpdateAnimalScreenState extends State<UpdateAnimalScreen> {
  TextEditingController _commonNameController = TextEditingController();
  TextEditingController _scientificNameController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _imageAuthorController = TextEditingController();

  File? _imageFile;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _updateAnimalInfo() async {

    final animalRef = FirebaseFirestore.instance.collection('avesdgo').doc(widget.animalId);

    if (_imageFile != null) {
      // Upload the new image to Firebase Storage and get its URL
      final storageRef = FirebaseStorage.instance.ref().child('${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Update the image URL in Firestore
      await animalRef.update({'foto': imageUrl});
      await animalRef.update({
        'foto': storageRef,
      });
    }

    // Update the animal information in Firestore
    if(_commonNameController.text.toString()!=""){
      await animalRef.update({
        'nombrecom': _commonNameController.text.toString(),
      });
    }
    if(_scientificNameController.text.toString()!=""){
      await animalRef.update({
        'nombrecien': _scientificNameController.text.toString()
      });
    }
    if(_imageAuthorController.text.toString()!=""){
      await animalRef.update({
        'credencial': _imageAuthorController.text.toString()
      });
    }



    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Información actualizada correctamente (^・ω・^ )')),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _commonNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre común',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _scientificNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Científico',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _imageAuthorController,
                decoration: InputDecoration(
                  labelText: 'Fotografiada por ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : Container(),
              ElevatedButton(
                onPressed: _getImageFromGallery,
                child: Text('Seleccionar imagen'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _updateAnimalInfo();
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}