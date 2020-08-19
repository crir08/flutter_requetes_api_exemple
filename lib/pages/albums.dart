import 'package:flutter/material.dart';
import 'package:requetes_api/modeles/album.dart';
import 'package:requetes_api/pages/ajout_album.dart';
import 'package:requetes_api/pages/modification_album.dart';
import 'package:requetes_api/services/album.service.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: _buildAlbums(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutAlbum()),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAlbums() {
//    AlbumService.obtenirAlbums();
    return FutureBuilder<List<Album>>(
      future: AlbumService.obtenirAlbums(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext _context, int index) {
                return ListTile(
                  leading: Text(snapshot.data[index].id.toString()),
                  title: Text(snapshot.data[index].title),
                  trailing: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmationSuppression(snapshot.data[index]);
                    },
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModificationAlbum(album: snapshot.data[index],)),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                );
              }
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

  Future<void> _confirmationSuppression(Album album) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Voulez-vous vraiment supprimer ' + album.title + '?'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                Navigator.of(context).pop();
                _supprimerAlbum(album);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  void _supprimerAlbum(Album album) {
    AlbumService.supprimerAlbum(album.id.toString());
  }
}


