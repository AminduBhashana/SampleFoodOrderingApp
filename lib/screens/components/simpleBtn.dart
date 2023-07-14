import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key, required this.text, required this.press,required this.btnColor, required this.btntxtColor
  });

  final String text;
  final VoidCallback press;
  final Color btnColor;
  final Color btntxtColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: (){
        press();
      }, 
      style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          fixedSize:  Size(0.8*width, 50),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),foregroundColor: btnColor),
      child:  Text(text.toUpperCase(),style:  TextStyle(color: btntxtColor,fontSize: 18,fontWeight: FontWeight.normal),),
      );
  }
}

class SimpleButton2 extends StatelessWidget {
  const SimpleButton2({
    super.key, required this.text, required this.press,required this.btnColor, required this.btntxtColor
  });

  final String text;
  final VoidCallback press;
  final Color btnColor;
  final Color btntxtColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: (){
        press();
      }, 
      style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          fixedSize:  Size(0.8*width, 50),
          side:  BorderSide(
                  width: 2.0,
                  color: btntxtColor,),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),),
      child:  Text(text.toUpperCase(),style:  TextStyle(color: btntxtColor,fontSize: 18,fontWeight: FontWeight.normal),),
      );
  }
}
