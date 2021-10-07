import 'package:flutter/material.dart';

class ControllerPokemons extends ChangeNotifier {

  int _wichClickSeeAll = 0; //selected all

  int _setButtonSearchId = 0;

  String _nameType = "";

  List<String> favoriteId = [];


  int _countFavorite = 0;


  get wichClickSeeAll {
    return this._wichClickSeeAll;
  }

  set wichClickSeeAll(int wichClickSeeAll) {
    this._wichClickSeeAll = wichClickSeeAll;
    notifyListeners();
  }

  get setButtonSearchId {
    return this._setButtonSearchId;
  }

  set setButtonSearchId(int setButtonSearchId) {
    this._setButtonSearchId = setButtonSearchId;
    notifyListeners();
  }

  set nameType(String nameType) {
    this._nameType = nameType;
    notifyListeners();
  }

  get nameType {
    return this._nameType;
  }

  set countFavorite(int countFavorite) {
    this._countFavorite = countFavorite;
    notifyListeners();
  }

  get countFavorite {
    return this._countFavorite;
  }


}
