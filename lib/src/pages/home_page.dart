import 'package:flutter/material.dart';

import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/search/search_delegate.dart';

import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/horizontal_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies in theaters'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiper_movies_in_theaters(),
            _swiper_popular_movies(context),
          ],
        ),
      ),
      /* body: SafeArea(child:
      Text('Hello World')
      ),*/
    );
  }

  Widget _swiper_movies_in_theaters() {
    return FutureBuilder(
        future: moviesProvider.getMovies(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //snapshot.data?.forEach((movie) => print(movie.title));
            return CardSwiper(movies: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });

    //moviesProvider.getMovies();
    //return CardSwiper(movies: [1, 2, 3, 4, 5]);
  }

  Widget _swiper_popular_movies(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular Movies',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),

          /*FutureBuilder(
          future: moviesProvider.getPopularMovies(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

            if (snapshot.hasData) {
              return HorizontalSwiper(movies: snapshot.data);
            } else {
              return Container(
                  height: 400.0,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              );
            }

          }),*/
          StreamBuilder(
              stream: moviesProvider.popularMoviesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return HorizontalSwiper(
                    movies: snapshot.data,
                    nextPage: moviesProvider.getPopularMovies,
                  );
                } else {
                  return Container(
                      height: 400.0,
                      child: Center(child: CircularProgressIndicator()));
                }
              })
        ],
      ),
    );
  }
}
