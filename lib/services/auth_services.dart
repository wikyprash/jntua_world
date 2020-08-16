import 'package:jntua_world/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'cloudFirestore_services.dart';

class AuthService {
  final FirebaseAuth _fbauthIntance = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // create custom user from firebase user
  User _customUserFromFirebaseUser(FirebaseUser fbuser) {
    return fbuser != null
        ? User(
            uid: fbuser.uid,
            name: fbuser.displayName,
            email: fbuser.email,
            photoUrl: fbuser.photoUrl,
          )
        : null;
  }

  //auth change stream
  Stream<User> get user {
    return _fbauthIntance.onAuthStateChanged.map(_customUserFromFirebaseUser);
  }
  // Stream<FirebaseUser> get user {
  //   return _fbauthIntance.onAuthStateChanged;
  // }

  //signIn anon
  Future signinAnon() async {
    try {
      AuthResult authResult = await _fbauthIntance.signInAnonymously();
      return _customUserFromFirebaseUser(authResult.user);
    } catch (e) {
      print('catching when signin anon >>> ');
      print(e);
      return null;
    }
  }

  //sign in with google
  // https://stackoverflow.com/questions/54067162/how-to-handle-platform-exception-when-sign-in-flow-cancelled-by-user
  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseUser user;
    var errorMessage;

    try {
      GoogleSignInAccount googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) {
        errorMessage = "CANCELLED_SIGN_IN";
        print('>>>>> $errorMessage <<<<<<<<');
        return Future.error(errorMessage);
      }

      GoogleSignInAuthentication googleAuthentication =
          await googleAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      AuthResult authResult =
          await _fbauthIntance.signInWithCredential(credential);
      user = authResult.user;
      final cfsInstance = CloudFiresotreService(uid: user.uid);
      cfsInstance.setNewuserData();
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          errorMessage = "Account already exists with a different credential.";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Invalid credential.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened. ";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return null;
  }

  //signOut
  Future signOut() async {
    try {
      googleSignIn.signOut();
      return await _fbauthIntance.signOut();
    } catch (e) {
      print('cathcing when signing out >>> ');
      print(e.toString());
      return null;
    }
  }

  // sign in with google Archive
  Future signInWithGoogleArchive() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _fbauthIntance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _fbauthIntance.currentUser();
      assert(user.uid == currentUser.uid);
      return _customUserFromFirebaseUser(authResult.user);
    } catch (e) {
      print('catching when signin with google >>> ');
      print(e);
      return null;
    }
  }
}
