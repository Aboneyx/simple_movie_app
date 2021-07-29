import 'package:sembast/sembast.dart';
import 'package:simple_movie_app/data/model/movie_model.dart';
import 'package:simple_movie_app/databases/database.dart';

class DBLogic {
  static const String store = 'movies';

  final _movies = intMapStoreFactory.store(store);

  Future<Database> get db async => await MovieDB.instance.db;

  Future insert(Results results) async {
    await _movies.add(await db, results.toMap());
  }

  Future deleteAll() async {
    await _movies.delete(
      await db,
    );
  }

  Future updateOrInsert(Results results) async {
    await _movies
        .record(int.parse('${results.id}'))
        .put(await db, results.toMap());
  }

  Future<List<Results>> getAllMovies() async {
    final snapshot = await _movies.find(await db);

    return snapshot.map((map) {
      final result = Results.fromMap(map.value);
      result.setId(map.key);
      return result;
    }).toList();
  }

  Future<List<Results>> getAll() async {
    final recordSnapshot = await _movies.find(await db);
    return recordSnapshot.map((snapshot) {
      final result = Results.fromMap(snapshot.value);
      return result;
    }).toList();
  }

  Future<List<Results>> getAllSortByRate() async {
    final finder = Finder(sortOrders: [
      SortOrder('voteAverage'),
    ]);

    final recordSnapshot = await _movies.find(
      await db,
      finder: finder,
    );

    return recordSnapshot.map((snapshot) {
      final result = Results.fromMap(snapshot.value);
      result.setId(snapshot.key);
      return result;
    }).toList();
  }
}
