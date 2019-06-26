import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class UserRepository with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    "https://www.googleapis.com/auth/fitness.activity.read"
  ]);
  FirebaseAuth _auth;
  FirebaseUser _user;
  String _accessToken;
  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  String get accessToken => _accessToken;
  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      await _auth.signInWithGoogle(
        accessToken:  googleAuth.accessToken,
        idToken:  googleAuth.idToken
      );

      _accessToken = googleAuth.accessToken;
      notifyListeners();

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      _accessToken = null;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();

    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}


