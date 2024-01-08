// my custom button

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
