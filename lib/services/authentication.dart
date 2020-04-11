import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _goggleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // Get userId (UID)
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // Get current User
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<String> createUserwithEmailandPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    //update user name
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  //Update User's Name
  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userupdateinfo = UserUpdateInfo();
    userupdateinfo.displayName = name;

    await currentUser.updateProfile(userupdateinfo);
    await currentUser.reload();
  }

  // Email and password signIn
  Future<String> signInWithEmailandPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult.user.uid;
  }

  // sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // reset password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Google sign in
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _goggleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}

// Validators for Form field

// Name Validator
class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }

    if (value.length < 2) {
      return "Name must be atleast 2 characters long";
    }

    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be atleast 6 characters long";
    }
    return null;
  }
}