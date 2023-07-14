import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';

showAlertDialog(BuildContext context,String title,String text,VoidCallback press) {
  Widget okButton  = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor
    ),    
    child: const Text("OK",style: TextStyle(color: Colors.white),),
    onPressed: () {
      press();
     },
  );

  AlertDialog alert = AlertDialog(
    title:  Text(title),
    content:  Text(text),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ); 
}

alertDialog(BuildContext context, String msg) {
  return msg;
}