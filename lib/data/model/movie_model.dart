
import 'dart:convert';

List<Results> modelResultsFromJson(String str) => List<Results>.from(json.decode(str).map((x) => Results.fromJson(x)));
String modelResultsToJson(List<Results> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class MovieModel {
  int? _page;
  List<Results>? _results;

  int? get page => _page;
  List<Results>? get results => _results;


  MovieModel({
      int? page, 
      List<Results>? results,}){
    _page = page;
    _results = results;

}

  MovieModel.fromJson(dynamic json) {
    _page = json["page"];
    if (json["results"] != null) {
      _results = [];
      json["results"].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["page"] = _page;
    if (_results != null) {
      map["results"] = _results?.map((v) => v.toJson()).toList();
    }

    return map;
  }

}

class Results {
  String? _backdropPath;
  int? _id;
  String? _overview;
  String? _posterPath;
  String? _releaseDate;
  String? _title;
  double? _voteAverage;

  String? get backdropPath => _backdropPath;
  int? get id => _id;
  String? get overview => _overview;
  String? get posterPath => _posterPath;
  String? get releaseDate => _releaseDate;
  String? get title => _title;
  double? get voteAverage => _voteAverage;

  setId(int id) {
    _id = id;
  }

  Results({
      String? backdropPath, 
      int? id,
      String? overview, 
      String? posterPath,
      String? releaseDate, 
      String? title,
      double? voteAverage,
      }){
    _backdropPath = backdropPath;
    _id = id;
    _overview = overview;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
    _voteAverage = voteAverage;
}

  Results.fromJson(dynamic json) {
    _backdropPath = json["backdrop_path"];
    _id = json["id"];
    _overview = json["overview"];
    _posterPath = json["poster_path"];
    _releaseDate = json["release_date"];
    _title = json["title"];
    _voteAverage = json["vote_average"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["backdrop_path"] = _backdropPath;
    map["id"] = _id;
    map["overview"] = _overview;
    map["poster_path"] = _posterPath;
    map["release_date"] = _releaseDate;
    map["title"] = _title;
    map["vote_average"] = _voteAverage;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'backdropPath': _backdropPath,
      'id': _id,
      'overview': _overview,
      'posterPath': _posterPath,
      'releaseDate': _releaseDate,
      'title': _title,
      'voteAverage': _voteAverage,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) => Results(
      backdropPath: map['backdropPath'],
      id: map['id'],
      overview: map['overview'],
      posterPath: map['posterPath'],
      releaseDate: map['releaseDate'],
      title: map['title'],
      voteAverage: map['voteAverage'],
  );
}