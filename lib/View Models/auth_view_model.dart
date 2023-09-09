import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xo_game/Views/Multiplayer/invite_player_view.dart';
import 'package:xo_game/Views/Multiplayer/landing_view.dart';
import 'package:xo_game/utils/firebase_functions.dart';
import 'package:xo_game/utils/snackbar.dart';
import 'package:xo_game/utils/string_manager.dart';

import '../utils/functions.dart';

class AuthViewModel with ChangeNotifier {
  //Vars
  bool _actionLoading = false;
  User? _user;
  bool _isEmailFilled = false;
  bool _isPasswordFilled = false;
  bool _isNameFilled = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Setters

  void initCotrollers() {
    _emailController.addListener(() {
      if (_emailController.text.trim().isNotEmpty) {
        setIfEmailFilled(state: true);
      } else {
        setIfEmailFilled(state: false);
      }
    });
    _passwordController.addListener(() {
      if (_passwordController.text.trim().isNotEmpty &&
          _passwordController.text.trim().length >= 6) {
        setIfPasswordFilled(state: true);
      } else {
        setIfPasswordFilled(state: false);
      }
    });
    _nameController.addListener(() {
      if (_passwordController.text.trim().isNotEmpty) {
        setIfNameFilled(state: true);
      } else {
        setIfNameFilled(state: false);
      }
    });
  }

  void setActionLoadingState({required bool state}) {
    _actionLoading = state;
    notifyListeners();
  }

  void setIfEmailFilled({required bool state}) {
    _isEmailFilled = state;
    notifyListeners();
  }

  void setIfNameFilled({required bool state}) {
    _isNameFilled = state;
    notifyListeners();
  }

  void setIfPasswordFilled({required bool state}) {
    _isPasswordFilled = state;
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      setActionLoadingState(state: true);
      if (!await isDuplicateUniqueName(getNameController.text.trim())) {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: getEmailController.text.trim(),
                password: getPasswordController.text.trim());
        if (result.user != null) {
          _user = result.user;
          await _user!.updateDisplayName(getNameController.text.trim());

          showSnackbar(
              success: true,
              context: context,
              message: StringManager.successfullyRegistered);
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          final users = firestore.collection('users');
          final user = await users.add({
            'name': getNameController.text.trim(),
            'id': _user!.uid,
          });
          await setUserData(
              id: _user!.uid, name: getNameController.text.trim());
          resetControllers();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MultiplayerLandingView(),
              ));
          notifyListeners();
        }
      } else {
        showSnackbar(
            context: context,
            message: StringManager.duplicatedName(
                name: getNameController.text.trim()),
            success: false);
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(
          context: context, message: e.message ?? e.code, success: false);
    } on Exception catch (e) {
      log(e.toString());
    }
    setActionLoadingState(state: false);
  }

  void resetControllers() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
  }

  //Getters
  bool get getActionLoadingState => _actionLoading;
  bool get getIfEmailFilled => _isEmailFilled;
  bool get getIfPasswordFilled => _isPasswordFilled;
  bool get getIfNameFilled => _isNameFilled;
  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  TextEditingController get getNameController => _nameController;
}
