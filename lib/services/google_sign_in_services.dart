
//class for handle google sign in services

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../successful_login_page.dart';

class SignInWithGoogle {
  User? user;
  bool isLoadingGoolgle =  false ;
  // instance of google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //google sign in methods

  Future<void> googleSignIn(
      BuildContext context,
      ) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      if (googleSignInAccount != null) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication?.accessToken,
            idToken: googleSignInAuthentication?.idToken));
        user = userCredential.user;
        if (user != null)
          print(
              "userEmail : ${user?.email}\n User Name ${user?.displayName} \n User PhoneNumber ${user?.phoneNumber} ");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessFullLoginPage(
                userEmail: user?.email ?? "",
                userName: user?.displayName ?? "",
                userNumber: user?.photoURL ?? "",
              ),
            ));
        //    isLoading  = false ;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      //  isLoading = false ;
    }
  }

  //google sign out method

  Future<void> googleSignOut() async {
    _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    //isLoading = false  ;
  }
}
