import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/components/simpleBtn.dart';
import 'package:food_ordering_app/screens/components/textStyles.dart';
import 'package:food_ordering_app/screens/loginScreen.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 0.05*height,),
          Expanded(
           child: Center( 
          child:  Image( 
              image:  const AssetImage(
                "assets/images/image3.png",),
              height: 0.8*height,
              width: 0.8*width,
            ),
        ),
     ),
     SizedBox(height: 0.02*height,),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Welcome To FastFood",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 0.02*height,),
                const Column(
                  children: [
                    SimpleText1(text: "Order Your all kind of food requirements"),
                    SimpleText1(text: "We have many shops to serve you")
                  ],
                ),
                SizedBox(height: 0.09*height,),
                SimpleButton(
                  text: 'Get Started', 
                  press: (){
                    Get.off(() => const LoginScreen());
                  },
                  btnColor: kPrimaryColor,
                  btntxtColor: Colors.white,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
