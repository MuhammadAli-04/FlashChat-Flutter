import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FirebaseData {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance.ref();

  static Map<String, dynamic>? _currentUser;
  static List<Map<String, dynamic>> _usersData = [];
  static List<dynamic> _usernames = [];

  FirebaseData() {
    initiliazeUser();
    initiliazeData();
  }

  void initiliazeUser() async {
    if (_auth.currentUser != null) {
      print("user available");
      await _firestore
          .collection('Users')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          _currentUser = doc.data();
        }
      });
    } else {
      print("user not logged in");
    }
  }

  void initiliazeData() async {
    _firestore.collection('Usernames').get().asStream().listen((event) {
      for (var doc in event.docs) {
        _usernames = doc.data()['usernames'];
      }
    });

    _firestore.collection('Users').get().asStream().listen((event) {
      _usersData = event.docs.map((e) => e.data()).toList();
    });
  }

  Map<String, dynamic>? getCurrentUserData() => _currentUser;
  List<dynamic> getUsernames() => _usernames;
  List<Map<String, dynamic>> getUsersData() => _usersData;

  Future<bool> signinUser(
      String email, String password, Function showSnackBar) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showSnackBar(e.toString());
      return false;
    }
    initiliazeUser();
    showSnackBar("${_currentUser!['username']} logged in!");
    return true;
  }

  Future<bool> signupUser(String name, String? imgPath, String email,
      String password, String username, Function showSnackBar) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var data = {
        'name': name,
        'imgPath': imgPath,
        'email': email,
        'username': username
      };
      await _firestore.collection('Users').add(data);
      _firestore.collection('Usernames').doc('Usernames').update({
        "usernames": FieldValue.arrayUnion([username]),
      });
      String _username = await _firestore
          .collection('Users')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          return doc.data()['username'];
        }
        return "";
      });
      showSnackBar("user created : $_username");

      initiliazeUser();
    } catch (e) {
      e.toString();
    }
    return true;
  }

  Future<bool> signOut(Function showSnackBar) async {
    try {
      await _auth.signOut();
      showSnackBar("User logged out successfully");
      _currentUser = null;
      return true;
    } catch (e) {
      showSnackBar("There was some error. Please Try again");
      return false;
    }
  }

  Future<bool> storeImage(
      XFile file, Function state, Function showSnackBar) async {
    Reference imgDir = _storage.child("Images").child(file.name);
    try {
      imgDir
          .putFile(File(file.path.toString()))
          .snapshotEvents
          .listen((snapshot) async {
        switch (snapshot.state) {
          case TaskState.success:
            showSnackBar("Upload Successful");
            String path = await imgDir.getDownloadURL();
            state(path);
            break;
          case TaskState.error:
            showSnackBar("Some error occurred,Please Try again!");
            break;
          default:
            break;
        }
      });
    } catch (e) {
      showSnackBar(e.toString());
      return false;
    }
    return true;
  }
}
