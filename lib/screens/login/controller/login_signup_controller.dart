import 'package:flutter/material.dart';

// ignore: camel_case_types
class loginController extends ChangeNotifier {
  bool _emailInvalido = false;
  bool _senhaInvalida = false;

  get emailInvalido => this._emailInvalido;
  get senhaInvalida => this._senhaInvalida;

  set emailInvalido(bool emailInvalido) {
    this._emailInvalido = emailInvalido;
    notifyListeners();
  }

  set senhaInvalida(bool senhaInvalida) {
    this._senhaInvalida = senhaInvalida;
    notifyListeners();
  }

  void resetData() {
    this._senhaInvalida = false;
    this._emailInvalido = false;
  }
}

// ignore: camel_case_types
class signUpController extends ChangeNotifier {
  bool _emailInvalido = false;
  bool _senhaInvalida = false;
  bool _firstName = false;
  bool _lastName = false;

  get emailInvalido => this._emailInvalido;
  get senhaInvalida => this._senhaInvalida;
  get firstName => this._firstName;
  get lastName => this._lastName;

  set emailInvalido(bool emailInvalido) {
    this._emailInvalido = emailInvalido;
    notifyListeners();
  }

  set senhaInvalida(bool senhaInvalida) {
    this._senhaInvalida = senhaInvalida;
    notifyListeners();
  }

  set firstName(bool firstName) {
    this._firstName = firstName;
    notifyListeners();
  }

  set lastName(bool lastName) {
    this._lastName = lastName;
    notifyListeners();
  }


  void resetData() {
    this._senhaInvalida = false;
    this._emailInvalido = false;
    this._firstName = false;
    this._lastName = false;
  }
}
