import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xo_game/main.dart';
import 'package:xo_game/utils/snackbar.dart';

class MultiplayerViewModel with ChangeNotifier {
//Vars
  bool _actionLoading = false;
  final _nameController = TextEditingController();
  bool _isNameFilled = false;

//Setters

  void setIsNameFilled({required bool state}) {
    _isNameFilled = state;
    notifyListeners();
  }

  void setActionLoadingState({required bool state}) {
    _actionLoading = state;
    notifyListeners();
  }

  void initCotrollers() {
    _nameController.addListener(() {
      if (_nameController.text.trim().isNotEmpty) {
        setIfNameFilled(state: true);
      } else {
        setIfNameFilled(state: false);
      }
    });
  }

  void setIfNameFilled({required bool state}) {
    _isNameFilled = state;
    notifyListeners();
  }

  Future<void> search({required BuildContext context}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("matches/");
    showSnackbar(context: context, message: ref.root.toString(), success: true);
    await ref.set({
      "match:${sharedPreferences.getString('name')}-${getNameController.text.trim()}":
          {
        'player1': sharedPreferences.getString('name'),
        'player2': getNameController.text.trim(),
      }
    });
  }

  Future<DocumentSnapshot> getUsers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference users = firestore.collection('users');
    return await users.doc().get();
  }

//Getters
  bool get getActionLoadingState => _actionLoading;
  TextEditingController get getNameController => _nameController;
  bool get getIsNameFilled => _isNameFilled;
}
