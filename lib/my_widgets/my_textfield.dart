import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// my custom text-field

class MyTextField extends StatelessWidget {
  final IconData prefixIcon;
  final IconData ?suffixIcon;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged ;
  final String? Function(String?)? validator ;
  final void Function()? onSuffixIconTap ;

  const MyTextField({
    super.key,
    required this.prefixIcon,
    this.suffixIcon ,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged, this.validator, this.onSuffixIconTap,
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
        suffixIcon:  IconButton(icon: Icon(suffixIcon), onPressed:onSuffixIconTap,) ,
        hintText: hintText,
      ),
      onChanged: onChanged ,
      validator: validator,
    );
  }
}