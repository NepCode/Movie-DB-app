import 'package:flutter/material.dart';

import 'package:movies_app/src/models/cast_model.dart';
import 'package:movies_app/src/models/movie_model.dart';

import 'package:movies_app/src/providers/movies_provider.dart';


class MovieDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10.0),
              _titlePoster(context, movie),
              _description(context, movie),
              _showCasting(context, movie),
            ]
          ),
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.red,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 16.0),),
        background: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.getBackgroundImg()),
            fadeInDuration: Duration(microseconds: 3000),
            fit: BoxFit.cover,
        ),
      )
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child:
                Image(
                  image: NetworkImage(movie.getPosterImg()),
                  height: 150.0,
                )
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ),
              Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon( Icons.star_border),
                  Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text( movie.overview, textAlign: TextAlign.justify ),
    );
  }

  Widget _showCasting(BuildContext context, Movie movie) {

    final movieProvider = new MoviesProvider();

    return FutureBuilder(
       future: movieProvider.getCast(movie.id.toString()),
       builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
         if (snapshot.hasData) {
          return _castingPageView(snapshot.data);
         } else {
           return Container(
               height: 400.0,
               child: Center(child: CircularProgressIndicator()));
         }
       }
    );

  }


  
  Widget _castingPageView(List<Actor> actors) {
    
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1  
          ),
          itemCount: actors.length,
        itemBuilder: (context, i) {
            //return Text( actors[i].name );
          return _actorsCards( actors[i]);
        },
      ),
    );
  }

  Widget _actorsCards( Actor actor) {
    return Container(
      //padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( actor.getActorPhoto() ),
                placeholder: AssetImage('assets/no-image.jpg'),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
    );
  }



}

