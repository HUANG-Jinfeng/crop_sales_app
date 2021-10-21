import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? email;
  String? password;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    try {
      startLoading();
      if (email != null && password != null) {
        // ログイン
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);

        //final currentUser = FirebaseAuth.instance.currentUser;
        //final uid = currentUser!.uid;
      }
    } catch (e) {
      //handleError(e);
      throw "You don't seem to have registered.";
      return null;
    }
  }
}