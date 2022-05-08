// ignore_for_file: unnecessary_this, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_integration/user.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginController with ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleAccount;
  UserDetails? userDetails;

  googleLogin() async {
    this._googleAccount = await _googleSignIn.signIn();
    // ignore: unnecessary_new
    this.userDetails = new UserDetails(
      displayName: this._googleAccount!.displayName,
      email: this._googleAccount!.email,
      photoUrl: this._googleAccount!.photoUrl,
    );
    notifyListeners();
  }

  facebookLogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      // ignore: unnecessary_new
      this.userDetails = new UserDetails(
          displayName: requestData['name'],
          email: requestData['email'],
          photoUrl: requestData['picture']['data']['url']);

      notifyListeners();
    }
  }

  twitterLogin() async {
    final twitterLogin = TwitterLogin(
        apiKey: "KFD6lLwtLtJkUwkoBHEqhZX46",
        apiSecretKey: "RYFScb40lcbYuyPLdNcispZ5mgG7Z97DQIOR9aIbYEChUqQXv1",
        redirectURI: "https://sparks-fb5b0.firebaseapp.com/__/auth/handler");
    final authResult = await twitterLogin.login(forceLogin: true);
    final AuthCredential credential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!);
    await FirebaseAuth.instance.signInWithCredential(credential);
    // ignore: unnecessary_new
    // this.userDetails = new UserDetails(
    //   displayName: this._googleAccount!.displayName,
    //   email: this._googleAccount!.email,
    //   photoUrl: this._googleAccount!.photoUrl,
    // );
    notifyListeners();
  }

  logOut() async {
    this._googleAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}
