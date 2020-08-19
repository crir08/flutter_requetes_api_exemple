import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:requetes_api/modeles/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static final url = 'https://jsonplaceholder.typicode.com/';

  // Obtient l'album correspondant à l'id entré en paramètres.
  static Future<Album> obtenirAlbum(int id) async {
    final response = await http.get(url + 'albums/' + id.toString());

    if (response.statusCode == 200) {
      // Si le serveur retourne un code 200,
      // on convertit la réponse en JSON.
      return Album.fromJson(json.decode(response.body));
    } else {
      // Si le serveur n'a pas retourné de code 200,
      // une exception est levée.
      throw Exception('L\'obtention de l\'album a échouée...');
    }
  }

  // Obtient l'ensemble des albums de l'api.
  static Future<List<Album>> obtenirAlbums() async {
    final response = await http.get(url + 'albums');

    if (response.statusCode == 200) {
      // Si le serveur retourne un code 200,
      // on convertit la réponse en JSON.
      var data = json.decode(response.body) as List;
      List<Album> albums = data.map((e) => Album.fromJson(e)).toList();

      return albums;
    } else {
      throw Exception('L\'obtention des albums a échouée...');
    }
  }

  // Ajoute un nouvel album.
  static Future<Album> ajouterAlbum(Album album) async {
    final response = await http.post(
      url + 'albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': album.title,
      }),
    );

    if (response.statusCode == 201) {
      print('Album ajouté avec succès!');
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Une erreur est survenue lors de l\'ajout de l\'album...');
    }
  }

  // Suppression de l'album correspondant à l'id.
  static Future<Album> supprimerAlbum(String id) async {
    final http.Response response = await http.delete(
      url + 'albums/' + id,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Suppression effectuée avec succès!');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Une erreur est survenue lors de la suppression de l\'album');
    }
  }

  // Modifie l'album sélectionné.
  static Future<Album> modifierAlbum(Album album) async {
    final http.Response response = await http.put(
      url + 'albums/' + album.id.toString(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': album.title,
      }),
    );

    if (response.statusCode == 200) {
      print("Album modifié avec succès");
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Une erreur est survenue lors de la modification de l\'album');
    }
  }
}