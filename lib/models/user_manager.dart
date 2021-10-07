import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/firebase/firebase_exception.dart';
import 'package:pokemonapp/models/user_model.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  UserModel user;
  bool _loading = false;

  bool get loading => _loading;
  set loading(bool loading) {
    this._loading = loading;
    notifyListeners();
  }

  bool get isLoggedIn {
    return user != null;
  }

  Future<void> signIn({
    UserModel user,
    Function onFail,
    Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(firebaseErrorMessage(e.code));
    }
    loading = false;
  }

  Future<void> signUp({
    UserModel user,
    Function onFail,
    Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(firebaseErrorMessage(e.code));
      _loading = false;
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await auth.signOut();
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection("users").doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUser);
      notifyListeners();
    }
  }

}
