
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;
  TextEditingController userNameController  = TextEditingController() ;
  TextEditingController passwordController  = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 5.w, right: 5.w, top: 9.h,),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: Device.height -14.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),) ,
                   SizedBox(height: 2.5.h,) ,
                   Align(alignment: Alignment.centerLeft,
                      child: Text("Username", style: TextStyle( fontSize: 17.sp),)) ,
                  // const SizedBox(height: 5,),
                  MyTextField(controller: userNameController , hintText: "Type your username",prefixIcon: Icons.person,keyboardType: TextInputType.name,validator: (value) {
                    return value?.isRequired (errorText: 'This field is required') ;
                  },) ,
                   SizedBox(height: 1.8.h,) ,
                   Align(alignment: Alignment.centerLeft,
                      child: Text("Password", style: TextStyle( fontSize: 17.sp),)) ,
                  // const SizedBox(height: 5,),
                  MyTextField(controller: passwordController , hintText: "Type your password",prefixIcon: Icons.lock,keyboardType: TextInputType.name,obscureText: true, validator: (value) {
                    return value?.isRequired(errorText: "This field is required") ;
                  },) ,
                   SizedBox(height: 1.h,) ,
                  Align(alignment: Alignment.centerRight,
                      child: Text("Forget password?", style: TextStyle( fontSize: 17.sp),)) ,
                   SizedBox(height: 2.h,) ,
                  MyButton(onTap: () {
               if (_formKey.currentState!.validate()) {

               }
                  },) ,
                   SizedBox(height: 3.5.h,) ,
                 Text("Or Sign Up Using", style: TextStyle( fontSize: 17.sp),) ,
                  SizedBox(height: 2.5.h,) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg_images/icons8-facebook.svg"),const SizedBox(width: 5,),
                  SvgPicture.asset("assets/svg_images/icons8-twitter-circled.svg"),const SizedBox(width: 5,),
                  SvgPicture.asset("assets/svg_images/icons8-google.svg"),
                ],
              ),
               //  const Spacer() ,
                 SizedBox(height: 22.h,) ,
                   Text("Or Sign Up Using", style: TextStyle( fontSize: 17.sp),) ,
                  SizedBox(height: 1.5.h,) ,
                   Text("Sign Up", style: TextStyle( fontSize: 17.sp),) ,
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
  final IconData prefixIcon ;
  final String hintText  ;
  final TextEditingController? controller ;
  final TextInputType? keyboardType ;
  final bool obscureText ;
  final String? Function(String?)? validator ;
  const MyTextField({
    super.key,
    required this.prefixIcon, required this.hintText, this.controller,this.keyboardType,  this.obscureText = false, this.validator ,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration:  InputDecoration(
    alignLabelWithHint: true ,
        prefixIcon: Icon(prefixIcon ) ,
        hintText: hintText ,

      ),
      validator: validator ,
    );
  }
}

class MyButton extends StatelessWidget {
  final void Function()? onTap ;
  const MyButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50/2),
          gradient:const LinearGradient( colors: [Colors.blue, Colors.purple],)
        ),
            child: const Center(child: Text("LOGIN", style: TextStyle(fontSize: 14, color: Colors.white),)),
      ),
    );
  }
}

extension Validation on String {
  isRequired({required String errorText}) {
    if(this=="" ) {
      return errorText ;
    }
    return null ;
  }
}


// Widget fittedBox () {
//   return Scaffold(
//     body: LayoutBuilder(builder: (context, constraints) {
//
//     },)
//   ) ;
// }