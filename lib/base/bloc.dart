import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier{
  /// показываем состояние загрузки
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _onError = false;
  bool get onError => _onError;

  /// показываем состояние и текст ошибки
  String _errorText = "";
  String get errorText => _errorText;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void catchOnError(bool error, String errorText) {
    _onError = error;
    _errorText = errorText;
    notifyListeners();
  }
}