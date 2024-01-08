import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/services/google_sign_in_services.dart';
import 'package:login_page/successful_login_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'exception/auth_exception_handler.dart';
import 'my_widgets/my_button.dart';
import 'my_widgets/my_textfield.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // global key for form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //text editing controllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //firebase auth instance
  final firebaseAuth = FirebaseAuth.instance;
  // variable for showing error messages

  String? errorMessage;
// varable for checking validation state
  bool _isValid = false ;
  //variable for loading
  bool isLoading = false;
  //variable to show or hide password ;
  bool isPasswordHidden = true ;


  // firebase sign up method
  Future<void> singUpUsingEmail() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userNameController.text,
              password: passwordController.text);
      userNameController.clear();
      passwordController.clear();
      setState(() {
        errorMessage == null;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have Successfully SignUp')));
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.code;
        AuthExceptionHandler.errorMessageFromErrorCode(errorMessage);
      });
    }
    if (errorMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage!)));
    }
  }
// sign in method
  Future<void> signInWithEmail() async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: userNameController.text, password: passwordController.text);
      setState(() {
        errorMessage == null;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You have successfully login")));
      userNameController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (exception) {
      setState(() {
        errorMessage = exception.code;
        AuthExceptionHandler.errorMessageFromErrorCode(errorMessage);
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage!)));
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    isLoading = true;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final SignInWithGoogle signInWithGoogle = SignInWithGoogle();

    return Scaffold(
      body:
      isLoading
         ? const Center(child: CircularProgressIndicator())
         :
      Padding(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26.sp),
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
                            return value?.isRequired(errorText: "This field is required") ;
                          },
                          onChanged: (value) {
                            final isValid = _formKey.currentState?.validate() ;
                            if (_isValid!=isValid) {
                              setState(() {
                                _isValid = isValid! ;
                                isLoading = false ;
                              }) ;
                            }
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
                          obscureText: isPasswordHidden,
                          suffixIcon: isPasswordHidden ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                          onSuffixIconTap: () {
                            setState(() {
                              isPasswordHidden != isPasswordHidden ;
                              isLoading  = false ;
                            }) ;
                          },
                          validator:  (value) {
                            return  value?.isRequired(
                                errorText: "This field is required");
                          },
                          onChanged: (value) {
                          final isValid =  _formKey.currentState?.validate() ;
                         if(_isValid!=isValid) {
                           setState(() {
                            _isValid = isValid! ;
                            isLoading= false ;
                           }) ;
                         }
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
                              _isValid =true ;
                            }
                            signInWithEmail();
                            setState(() {
                              isLoading = true;
                            });

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
                            SvgPicture.asset(
                                "assets/svg_images/icons8-facebook.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                                "assets/svg_images/icons8-twitter-circled.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () async {

                                  setState(() {
                                  isLoading = true  ;
                               //  signInWithGoogle.isLoadingGoolgle = true;
                              //   signInWithGoogle.isLoadingGoolgle = isLoading ;
                                   }) ;

                                  await signInWithGoogle.googleSignIn(context);

                                  setState(() {
                                    isLoading = false;
                                   });
                                },
                                child: SvgPicture.asset(
                                    "assets/svg_images/icons8-google.svg")),
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
                            style:
                                TextStyle(fontSize: 17.sp, color: Colors.black),
                          ),
                          onPressed: () {
                             if (_formKey.currentState!.validate()) {
                               _isValid =true ;
                             }
                            singUpUsingEmail();
                            setState(() {
                              isLoading = true;
                            });

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

// extension method for validation
extension Validation on String {
  isRequired({required String errorText}) {
    if (this == "") {
      return errorText;
    }
    return null;
  }
}
