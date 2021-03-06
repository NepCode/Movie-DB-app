import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';


class DataSearch extends SearchDelegate {

  String optionSelected = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Captain America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final recentMovies = [
    'Spiderman',
    'Captain America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
   /* return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(optionSelected),
      ),
    );*/
  }

/*  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final suggestedMovies = ( query.isEmpty ) ? recentMovies : movies.where( (m) => m.toLowerCase().startsWith(query.toLowerCase() ) ).toList() ;

    return ListView.builder(itemBuilder: (context,i) {
      return ListTile(
        leading: Icon(Icons.movie),
        title: Text(suggestedMovies[i]),
        onTap: () {
          optionSelected = suggestedMovies[i];
          showResults(context);
        },
      );
    }, itemCount: suggestedMovies.length);
  }*/

  @override
  Widget buildSuggestions(BuildContext context) {

    if ( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if( snapshot.hasData ) {

          final movies = snapshot.data;

          return ListView(
              children: movies.map( (movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage( movie.getPosterImg() ),
                    placeholder: AssetImage('assets/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text( movie.title ),
                  subtitle: Text( movie.originalTitle ),
                  onTap: (){
                    close( context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'movie_details', arguments: movie);
                  },
                );
              }).toList()
          );

        } else {
          return Center(
              child: CircularProgressIndicator()
          );
        }

      },
    );


  }





}