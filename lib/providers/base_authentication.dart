import 'package:firebase_auth/firebase_auth.dart';

abstract class Authentication {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<String> getAccessToken();
  Future<void> signOut();
}

class Auth implements Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign in with firebase authentication
  Future<String> signIn(String email, String password) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user.uid;
  }

  /// Sign up with firebase authentication
  Future<String> signUp(String email, String password) async {
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user.uid;
  }

  /// get access token user with fireabase authentication
  Future<String> getAccessToken() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    String token;
    await user.getIdToken().then((_token) {
      token = _token.token;
    });
    return token;
  }

  /// get current user with fireabase authentication
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    return user.uid;
  }

  /// sign out account.
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
