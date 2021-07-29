import 'package:simple_movie_app/base/bloc.dart';
import 'package:simple_movie_app/data/model/movie_model.dart';

import 'home_provider.dart';

class DetailsScreenProvider extends BaseBloc {
  late HomeProvider newModel;

  initData(HomeProvider previousModel, item) async {
    newModel = previousModel;
    notifyListeners();
  }

  changeIcon(Results item)
  {
    newModel.changeIcon(item);
    notifyListeners();
  }
}