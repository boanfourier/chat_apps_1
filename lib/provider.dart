import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserCredential? _user;
  bool _isLogin = true;

  Stream<User?> get check => _auth.authStateChanges();
  UserCredential? get user => _user;
  bool get isLogin => _isLogin;

  void setLog(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void setAuth() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result;
      notifyListeners();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = result;
      notifyListeners();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream getChatMessages() {
    return _db
        .collection('chat')
        .orderBy(
      'createdAt',
      descending: true,
    )
        .snapshots();
  }

}

