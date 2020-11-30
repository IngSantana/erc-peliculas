
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:el_real_cine/src/models/peliculas_model.dart';

class PeliculasProvider{
  String _apikey   = '7c9dc491fa4cffd54d850ba62141b5bd';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

final peliculas = new Peliculas.fromJsonList(decodeData['results']);


    return peliculas.items;

  }

}