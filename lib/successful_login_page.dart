 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/logIn_page.dart';
import 'package:login_page/services/google_sign_in_services.dart';

class SuccessFullLoginPage extends StatefulWidget {
  final String  userName ;
  final String  userEmail ;
  final String  userNumber ;

    SuccessFullLoginPage({super.key, required this.userName, required this.userEmail, required this.userNumber});

  @override
  State<SuccessFullLoginPage> createState() => _SuccessFullLoginPageState();
}

class _SuccessFullLoginPageState extends State<SuccessFullLoginPage> {
final SignInWithGoogle signInWithGoogle = SignInWithGoogle() ;
bool isLoading = false ;


   @override
   Widget build(BuildContext context) {

     return  Scaffold(
       body:
            isLoading ? const Center( child: CircularProgressIndicator(),) :
       Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             if(signInWithGoogle.user!=null)
             const Text("You have Successfully Login with following Detail")  ,
             Text(widget.userEmail),
             const SizedBox(height: 5,) ,
             Text(widget.userName) ,
             const SizedBox(height: 5,) ,
             Text(widget.userNumber) ,
             const SizedBox(height: 5,) ,
             ElevatedButton(onPressed: () {
               setState(() {
                 isLoading = true ;
               });
              signInWithGoogle.googleSignOut() ;
              setState(() {
                isLoading  = false ;
              });
              Navigator.pop(context) ;
             }, child: const Text("Sign Out"))
           ],
         ),
       ),
     );
   }
}
