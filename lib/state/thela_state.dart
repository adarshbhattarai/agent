import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_thela_dental_bot/entity/MedicalDetailDTO.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import  'package:firebase_auth/firebase_auth.dart' as auth;


class ThelaState extends ChangeNotifier {


  var current = WordPair.random();
  var history = <WordPair>[];
  MedicalDetailDTO? _user;
  MedicalDetailDTO? get user => _user;

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];


  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  loadUser() async{
    // TODO: Get from preferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    var firebaseUser = auth.FirebaseAuth.instance.currentUser;
    var userId = firebaseUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic> userDetails = userDoc.data() as Map<String, dynamic>;
      Map<String, dynamic>? medical = userDetails['medical'];
      _user = MedicalDetailDTO.fromMap(medical!);
      notifyListeners();
    }

  Future<void> saveUser(MedicalDetailDTO user) async {
    _user = user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toMap()));
    notifyListeners();
  }

  Future<void> clearUser() async {
    _user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    notifyListeners();
  }

  }
}

