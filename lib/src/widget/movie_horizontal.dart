//import 'dart:js';

import 'package:flutter/material.dart';

import 'package:el_real_cine/src/models/peliculas_model.dart';
  
class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> pelicula;
  final Function siguientePagina;

  final _pageController = new PageController(

    initialPage: 1,
    viewportFraction: 0.3,
  );
  
  MovieHorizontal({ @required this.pelicula, @required this.siguientePagina});


  @override
  Widget build(BuildContext context) {
  
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      } 
    });
  
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
        children: _tarjetas(context),
      ),
    );
  }


  List<Widget> _tarjetas(BuildContext context){
    return pelicula.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: 140.0,
                ),
            ),
            SizedBox(height:5.0),
            Text(pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }

}