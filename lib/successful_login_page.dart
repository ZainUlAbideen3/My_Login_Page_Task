 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/logIn_page.dart';

class SuccessFullLoginPage extends StatelessWidget {
  final String  userName ;
  final String  userEmail ;
  final String  userNumber ;

    SuccessFullLoginPage({super.key, required this.userName, required this.userEmail, required this.userNumber});
final SignInWithGoogle signInWithGoogle = SignInWithGoogle() ;
   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             if(signInWithGoogle.user!=null)
             const Text("You have Successfully Login with following Detail")  ,
             Text(userEmail),
             const SizedBox(height: 5,) ,
             Text(userName) ,
             const SizedBox(height: 5,) ,
             Text(userNumber) ,
             const SizedBox(height: 5,) ,
             ElevatedButton(onPressed: () {
              signInWithGoogle.googleSignOut() ;
              Navigator.pop(context) ;
             }, child: const Text("Sign Out"))

           ],
         ),
       ),
     );
   }
 }
