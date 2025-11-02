import 'package:expense_tracker/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", width: 100, fit: BoxFit.cover),
        SizedBox(height: 15),
        Text("Expenze", style: TextStyle(
          fontSize: 40,
          color: kMainColor,
          fontWeight: FontWeight.bold
        ),),
      ],
    );
  }
}
