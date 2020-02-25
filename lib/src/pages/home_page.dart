import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies.dart';

import 'package:movies_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies in theaters'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swiperCards()],
        ),
      ),
      /* body: SafeArea(child:
      Text('Hello World')
      ),*/
    );
  }

  Widget _swiperCards() {
    final moviesProvider = MoviesProvider();
    moviesProvider.getMovies();

    return CardSwiper(movies: [1, 2, 3, 4, 5]);
  }
}
