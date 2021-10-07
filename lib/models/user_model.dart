import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String password;
  String date;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  UserModel({
    this.email,
    this.id,
    this.firstName,
    this.lastName,
    this.password,
  });

  UserModel.fromDocument(DocumentSnapshot document){
    Map getDoc = document.data();
    id = document.id;
    firstName = getDoc["firstName"] as String;
    lastName = getDoc["lastName"] as String;
    email = getDoc["email"] as String;
  }

  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName' : this.firstName,
      'lastName': this.lastName,
      'email': this.email,
    };
  }
}
