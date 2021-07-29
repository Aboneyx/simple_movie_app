import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_movie_app/base/bloc.dart';
import 'package:simple_movie_app/data/model/movie_model.dart';
import 'package:simple_movie_app/data/services/movie_services.dart';
import 'package:simple_movie_app/databases/crud.dart';
import 'package:simple_movie_app/widgets/custom_snackbar.dart';

class HomeProvider extends BaseBloc {
  List<Results> results = [];
  Map<Results, bool> fav = {};
  List<Results> fromDB = [];
  var db = DBLogic();
  int counter = 2;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);


  final customCacheManager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 2),
    maxNrOfCacheObjects: 50,
  ));


  init() async {
    setLoading(true);

    fromDB = await db.getAllSortByRate();
    print(fromDB.length);
    if(fromDB.length > 20) {
      db.deleteAll();
      fromDB.clear();
    }

    if(fromDB.isNotEmpty && fromDB.length == 20) {
      results = fromDB.reversed.toList();
      for (int i = 0; i < results.length; i++) {
        fav.putIfAbsent(results[i], () => false);
      }
    } else {
      MovieService _provider = MovieService();
      try {
        var result = await _provider.getTopRated('1');
        final data = result["results"];
        for (Map i in data) {
          results.add(Results.fromJson(i));
        }
        for (int i = 0; i < results.length; i++) {
          fav.putIfAbsent(results[i], () => false);
          if(fromDB.length < 20) {
            db.updateOrInsert(results[i]);
          }
        }
        fromDB = await db.getAllSortByRate();
        print(fromDB.length);
      } catch (e) {
        print(e);
      }
    }

    setLoading(false);
    notifyListeners();
  }

  changeIcon(Results item) {
    if (fav.containsKey(item)) {
      if (fav[item] == true) {
        fav[item] = false;
        print('fav[item] = false');
      } else {
        fav[item] = true;

        print('fav[item] = true;');
      }
    }
    notifyListeners();
  }

  clearCache() async {
    DefaultCacheManager().emptyCache();

    imageCache!.clear();
    imageCache!.clearLiveImages();
    db.deleteAll();
    print('cache clear');
    notifyListeners();
  }

  Future<dynamic> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    clearCache();
    refreshController.refreshCompleted();
    notifyListeners();
  }

  Future<dynamic> onLoading(context) async {
    await Future.delayed(const Duration(milliseconds: 180));

    MovieService _provider = MovieService();
    try {
      var result = await _provider.getTopRated(counter.toString());
      counter++;
      print(counter.toString());
      final data = result["results"];
      for (Map i in data) {
        results.add(Results.fromJson(i));
      }
      for (int i = 0; i < results.length; i++) {
        fav.putIfAbsent(results[i], () => false);
      }
      print(results.length.toString());
    } catch(e) {
      showCustomSnackBar(context: context, message: '$e');
    }

    refreshController.loadFailed();
    notifyListeners();
  }

  loadMore(context) async {
    MovieService _provider = MovieService();
    try {
      var result = await _provider.getTopRated(counter.toString());
      counter++;
      print(counter.toString());
      final data = result["results"];
      for (Map i in data) {
        results.add(Results.fromJson(i));
      }
      for (int i = 0; i < results.length; i++) {
        fav.putIfAbsent(results[i], () => false);
      }
      print(results.length.toString());
    } catch(e) {
      showCustomSnackBar(context: context, message: '$e');
    }
    notifyListeners();
  }
}
