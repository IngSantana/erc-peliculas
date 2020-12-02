
import 'package:el_real_cine/src/models/peliculas_model.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apikey   = '7c9dc491fa4cffd54d850ba62141b5bd';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;



  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);


    return peliculas.items;
  }

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

  Future <List<Pelicula>> getPopulares() async{

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularesPage.toString()
      
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }

}