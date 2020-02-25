class Movies {

  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final movie = new Movie.fromJsonMap(item);
      items.add( movie );
    }

  }

}



class Movie {

  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap( Map<String, dynamic> movie ) {

    voteCount        = movie['vote_count'];
    id               = movie['id'];
    video            = movie['video'];
    voteAverage      = movie['vote_average'] / 1;
    title            = movie['title'];
    popularity       = movie['popularity'] / 1;
    posterPath       = movie['poster_path'];
    originalLanguage = movie['original_language'];
    originalTitle    = movie['original_title'];
    genreIds         = movie['genre_ids'].cast<int>();
    backdropPath     = movie['backdrop_path'];
    adult            = movie['adult'];
    overview         = movie['overview'];
    releaseDate      = movie['release_date'];


  }



}