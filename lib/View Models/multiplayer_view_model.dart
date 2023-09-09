// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xo_game/Views/Multiplayer/multiplayer_board.dart';
import 'package:xo_game/main.dart';
import 'package:xo_game/utils/snackbar.dart';
import 'package:xo_game/utils/string_manager.dart';

import '../utils/firebase_functions.dart';

class MultiplayerViewModel with ChangeNotifier {
//Vars
  bool _actionLoading = false;
  bool _waitingForResponse = false;
  final _nameController = TextEditingController();
  final _matchIdController = TextEditingController();
  bool _isNameFilled = false;
  bool _isMatchIdFilled = false;
  int? _matchId;

//Setters

  void setIsNameFilled({required bool state}) {
    _isNameFilled = state;
    notifyListeners();
  }

  void setIsMatchIdFilled({required bool state}) {
    _isMatchIdFilled = state;
    notifyListeners();
  }

  void setActionLoadingState({required bool state}) {
    _actionLoading = state;
    notifyListeners();
  }

  void setWaitingResponseState({required bool state}) {
    _waitingForResponse = state;
    notifyListeners();
  }

  void initNameController() {
    _nameController.addListener(() {
      if (_nameController.text.trim().isNotEmpty &&
          sharedPreferences.getString('name') != _nameController.text.trim()) {
        setIfNameFilled(state: true);
      } else {
        setIfNameFilled(state: false);
      }
    });
  }

  void initMatchIdController() {
    _matchIdController.addListener(() {
      if (_matchIdController.text.trim().isNotEmpty) {
        setIsMatchIdFilled(state: true);
      } else {
        setIsMatchIdFilled(state: false);
      }
    });
  }

  void setIfNameFilled({required bool state}) {
    _isNameFilled = state;
    notifyListeners();
  }

  Future<void> deleteMatch({required int id}) async {
    DatabaseReference match = FirebaseDatabase.instance.ref('matches/$id');
    await match.remove();
    _matchId = null;
    notifyListeners();
  }

  Future<void> search({required BuildContext context}) async {
    setWaitingResponseState(state: false);

    setActionLoadingState(state: true);
    final user = await getUser(name: getNameController.text.trim());
    if (user != null) {
      if (_matchId != null) {
        await deleteMatch(id: _matchId!);
      }
      _matchId = await generateMatchId();
      notifyListeners();
      if (_matchId != null) {
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("matches/$_matchId");
        await ref.set({
          'player1': sharedPreferences.getString('name'),
          'player2': getNameController.text.trim(),
          'player1Playes': {'0': -1},
          'player2Playes': {'0': -1},
          'accepted': false,
          'isFinished': false,
        });

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        final matches = firestore.collection('matches');

        await matches.add({
          'id': _matchId,
          'player1': sharedPreferences.getString('name'),
          'player2': getNameController.text.trim(),
        });
        setWaitingResponseState(state: true);
        DatabaseReference waiting =
            FirebaseDatabase.instance.ref('matches/$getMatchId');
        waiting.onValue.listen((event) {
          if ((event.snapshot.value as Map)['accepted'] == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MultiplayerBoard(isPlayer1: true)));
          }
        });
      } else {
        showSnackbar(
            context: context,
            message: StringManager.cannotCreateMatch,
            success: false);
      }
    } else {
      showSnackbar(
          context: context,
          message:
              StringManager.playerNotfound(name: getNameController.text.trim()),
          success: false);
    }
    setActionLoadingState(state: false);
  }

  Future<void> acceptInvite({required BuildContext context}) async {
    setActionLoadingState(state: true);
    try {
      final status = await isMatchExist(
          id: int.parse(getMatchIdController.text.trim()),
          name: sharedPreferences.getString('name') ?? '');
      if (status) {
        int matchId =
            getMatchId ?? int.tryParse(getMatchIdController.text.trim()) ?? -1;

        DatabaseReference match =
            FirebaseDatabase.instance.ref('matches/$matchId');
        await match.update({
          // 'player1': sharedPreferences.getString('name'),
          // 'player2': getNameController.text.trim(),
          // 'player1Playes': {},
          // 'player2Playes': {},
          'accepted': true,
          //'isFinished': false, //TODO:  check
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MultiplayerBoard(isPlayer1: false)));
        showSnackbar(context: context, message: "Matchmaked", success: true);
      } else
        showSnackbar(context: context, message: "Failed", success: false);
    } catch (e) {}
    setActionLoadingState(state: false);
  }

  Stream<DatabaseEvent> play() {
    int matchId =
        getMatchId ?? int.tryParse(getMatchIdController.text.trim()) ?? -1;
    DatabaseReference match = FirebaseDatabase.instance.ref('matches/$matchId');
    return match.onValue;
  }

  Future<void> updatePlay({
    required bool isPlayer1,
    required List<int> player1Playes,
    required List<int> player2Playes,
  }) async {
    int matchId =
        getMatchId ?? int.tryParse(getMatchIdController.text.trim()) ?? -1;

    DatabaseReference match = FirebaseDatabase.instance.ref('matches/$matchId');
    await match.update({
      // 'player1': sharedPreferences.getString('name'),
      // 'player2': getNameController.text.trim(),
      'player1Playes': player1Playes,
      'player2Playes': player2Playes,
      //'accepted': true,
      'isFinished': false, //TODO:  check
    });
  }

  Future<int?> generateMatchId() async {
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      int matchId = random.nextInt(10000);
      if (!await isIdExist(matchId)) {
        return matchId;
      }
    }
    return null;
  }

  Stream waitingForInitation() {
    DatabaseReference matches = FirebaseDatabase.instance.ref('matches/');
    return matches.onValue;
  }

  Future<Map<String, dynamic>?> getUser({required String name}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final users = firestore.collection('users');
    final data = await users.where('name', isEqualTo: name).get();
    if (data.docs.isNotEmpty && data.docs.length == 1) {
      return data.docs.first.data();
    }

    return null;
  }

//Getters
  bool get getActionLoadingState => _actionLoading;
  TextEditingController get getNameController => _nameController;
  TextEditingController get getMatchIdController => _matchIdController;
  bool get getIsNameFilled => _isNameFilled;
  bool get getIsMatchIdFilled => _isMatchIdFilled;
  bool get getWaitingResponseState => _waitingForResponse;
  int? get getMatchId => _matchId;
}
