import 'package:flutter/material.dart';

class SimpleText1 extends StatelessWidget {
  const SimpleText1({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(
      color: Colors.black,
      fontSize: 20,fontWeight: 
      FontWeight.w300));    
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 4),
            child:  Text(text,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),));
  }
}
