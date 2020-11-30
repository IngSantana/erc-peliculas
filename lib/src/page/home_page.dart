import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child:  Swiper(
  itemBuilder: (BuildContext context, int index) {
    return new Image.network(
      "http://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  itemWidth: 300.0,
  layout: SwiperLayout.STACK,
)
    );
  }
}
