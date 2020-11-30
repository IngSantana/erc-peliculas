import 'package:el_real_cine/src/providers/peliculas_provider.dart';
import 'package:el_real_cine/src/widget/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Pelicuas en Cartelera'),
          backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[_swiperTarjetas()],
          ),
        ));
  }

  Widget _swiperTarjetas() {

    final peliculasProviders = new PeliculasProvider();
    peliculasProviders.getEnCines();

    return CardSwiper(peliculas: [1,2,3,4,5],);
  }
}
