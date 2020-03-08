import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/src/models/movie_model.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = UniqueKey().toString();
          return Hero(
            tag: movies[index].uniqueId,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              /*child: Image.network(
                "http://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              ),*/
              child: GestureDetector(
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movies[index].getPosterImg()),
                    fit: BoxFit.cover,
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'movie_details', arguments: movies[index] );
                },
              ),
            ),
          );
        },
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.70,
        itemHeight: _screenSize.height * 0.50,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );





  }
}
