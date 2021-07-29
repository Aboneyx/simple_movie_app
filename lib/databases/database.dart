import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MovieDB {
  MovieDB._internal();

  static MovieDB get instance => _singleton;

  static final MovieDB _singleton = MovieDB._internal();

  static Database? _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  Future initDB() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, 'movies.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }

}