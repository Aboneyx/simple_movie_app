import 'dart:convert';

import 'package:http/http.dart' as http;

const url = 'https://api.themoviedb.org/3/movie';
const imagePath = 'https://image.tmdb.org/t/p/w500';


class MovieService {
  getTopRated(String page) async {
    try{
      final response = await http.get(
        Uri.parse(
            '$url/top_rated?api_key=f514d089d1947b31c9faf7236589d135&language=en-US&page=$page'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error fetching histories');
      }
    } catch(e) {
      print(e);
    }
  }
}
