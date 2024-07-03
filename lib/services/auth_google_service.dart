import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class AuthGoogleService {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null &&
        userCredential.additionalUserInfo!.isNewUser == true) {
      await DatabaseService(uid: userCredential.user!.uid).savingUserData(
          email: userCredential.user!.providerData.first.email,
          profilepic: userCredential.user!.providerData.first.photoURL);
    }

    return userCredential;
  }

  void signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
