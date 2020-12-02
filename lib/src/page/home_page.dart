import 'package:el_real_cine/src/providers/peliculas_provider.dart';
import 'package:el_real_cine/src/widget/card_swiper_widget.dart';
import 'package:el_real_cine/src/widget/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final peliculasProviders = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProviders.getPopulares();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas en Cartelera'),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProviders.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subtitle1,
              )),
          StreamBuilder(
            stream:  peliculasProviders.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              snapshot.data?.forEach((p) => print(p.title));

              if (snapshot.hasData) {
                return MovieHorizontal(
                  pelicula: snapshot.data,
                  siguientePagina: peliculasProviders.getPopulares,
                  );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
