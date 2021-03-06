import 'package:flutter/material.dart';
import 'package:requetes_api/modeles/album.dart';
import 'package:requetes_api/services/album.service.dart';

class AjoutAlbum extends StatefulWidget {
  @override
  _AjoutAlbumState createState() => _AjoutAlbumState();
}

class _AjoutAlbumState extends State<AjoutAlbum> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un album'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Titre *',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer un titre d\'album';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print(titleController.text);
                    AlbumService.ajouterAlbum(Album(
                      title: titleController.text,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Ajouter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
