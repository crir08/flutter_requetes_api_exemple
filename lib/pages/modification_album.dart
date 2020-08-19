import 'package:flutter/material.dart';
import 'package:requetes_api/modeles/album.dart';
import 'package:requetes_api/services/album.service.dart';

class ModificationAlbum extends StatefulWidget {
  final Album album;

  const ModificationAlbum({Key key, this.album}) : super(key: key);

  @override
  _ModificationAlbumState createState() => _ModificationAlbumState(album);
}

class _ModificationAlbumState extends State<ModificationAlbum> {
  final Album album;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  _ModificationAlbumState(this.album);

  @override
  void initState() {
    super.initState();
    if (album != null) {
      titleController.text = album.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un album'),
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
                    AlbumService.modifierAlbum(Album(
                      id: album.id,
                      title: titleController.text,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Enregistrer'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
