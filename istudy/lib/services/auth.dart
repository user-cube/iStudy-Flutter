import 'package:firebase_auth/firebase_auth.dart';
import 'package:istudy/models/user/user.dart';
import 'package:istudy/services/profile.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create user object based on firebase user

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in
  Future signInEmailPassword(String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print("SignIn Error: " + e.toString());
      return null;
    }
  }

  //register
  Future signUp(String email, String password, String name, int role) async {
    try {
      AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser firebaseUser = authResult.user;
      await ProfileService(uid: firebaseUser.uid).updateUserProfile(name, role);

      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print("SignUp Error: " + e.toString());
      return null;
    }
  }

  //sign out

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print("SignOut Error: " + e.toString());
      return null;
    }
  }
}
