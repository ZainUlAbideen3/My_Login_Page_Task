import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/successful_login_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  String? errorMessage;
  UserCredential? userCredential;

  Future<void> singUpUsingEmail() async {
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userNameController.text, password: passwordController.text);
      setState(() {
        errorMessage  == null ;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You have Successfully SignUp')));
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.code;
        AuthExceptionHandler.errorMessageFromErrorCode(errorMessage) ;
      });
    }
    if (errorMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage!)));
    }
  }

  Future<void> signInWithEmail() async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: userNameController.text, password: passwordController.text);
      setState(() {
        errorMessage == null ;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("You have successfully login")));
    } on FirebaseAuthException catch (exception) {
      setState(() {
        errorMessage = exception.code;
       AuthExceptionHandler.errorMessageFromErrorCode(errorMessage);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage! )));
    }

  }
@override
 void dispose() {
  userNameController.dispose();
  passwordController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    final SignInWithGoogle signInWithGoogle = SignInWithGoogle() ;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 9.h,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: Device.height - 14.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Username",
                        style: TextStyle(fontSize: 17.sp),
                      )),
                  // const SizedBox(height: 5,),
                  MyTextField(
                    controller: userNameController,
                    hintText: "Type your username",
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return value?.isRequired(
                          errorText: 'This field is required');
                    },
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 17.sp),
                      )),
                  // const SizedBox(height: 5,),
                  MyTextField(
                    controller: passwordController,
                    hintText: "Type your password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.name,
                    obscureText: true,
                    validator: (value) {
                      return value?.isRequired(
                          errorText: "This field is required");
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget password?",
                        style: TextStyle(fontSize: 17.sp),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signInWithEmail();
                      }
                    },
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Text(
                    "Or Sign Up Using",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg_images/icons8-facebook.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                          "assets/svg_images/icons8-twitter-circled.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async => await signInWithGoogle.googleSignIn(context),
                          child: SvgPicture.asset("assets/svg_images/icons8-google.svg")),
                    ],
                  ),
                  const Spacer(),
                  //    SizedBox(height: 22.h,) ,
                  Text(
                    "Or Sign Up Using",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  CupertinoButton(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 17.sp, color: Colors.black),
                    ),
                    onPressed: () {
                      singUpUsingEmail();
                    },
                  ),
                  // SizedBox(height: 2.h,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  const MyTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  @override

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  const MyButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50 / 2),
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            )),
        child: const Center(
            child: Text(
          "LOGIN",
          style: TextStyle(fontSize: 14, color: Colors.white),
        )),
      ),
    );
  }
}

extension Validation on String {
  isRequired({required String errorText}) {
    if (this == "") {
      return errorText;
    }
    return null;
  }
}

class SignInWithGoogle {
  User? user ;
  final GoogleSignIn _googleSignIn= GoogleSignIn(
    // scopes: scopes
  );
  Future<void> googleSignIn(BuildContext context) async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      if (googleSignInAccount != null) {
        UserCredential userCredential =    await FirebaseAuth.instance.signInWithCredential(
            await GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication?.accessToken,
                idToken: googleSignInAuthentication?.idToken));
        user   = userCredential.user ;
        if(user!=null)
        print("userEmail : ${user?.email}\n User Name ${user?.displayName} \n User PhoneNumber ${user?.phoneNumber} ") ;
        Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessFullLoginPage(
          userEmail: user?.email ?? "",userName: user?.displayName ?? "",userNumber: user?.photoURL ?? "",
        ),))
        ;
      }
    } on FirebaseAuthException catch (e) {
      print  (e) ;

    }
  }
Future<void> googleSignOut () async {
    _googleSignIn.signOut() ;
    FirebaseAuth.instance.signOut() ;
}
}

class AuthExceptionHandler {
 static String errorMessageFromErrorCode(String? errorCode) {
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":
        return "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        return "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        return "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return
        "Signing in with Email and Password is not enabled.";
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email is already in use";
        break;
      case "wrong-password":
        return "Wrong password";
        break;
      case "user-not-found":
        return "  User not found";
        break;
      case "user-disabled":
        return "User disabled.";
        break;
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}
