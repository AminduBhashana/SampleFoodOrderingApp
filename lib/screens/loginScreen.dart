import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/Customer/customerDashboard.dart';
import 'package:food_ordering_app/screens/Shop/shopDashboard.dart';
import 'package:food_ordering_app/screens/components/simpleBtn.dart';
import 'package:food_ordering_app/screens/components/textFieldForm.dart';
import 'package:food_ordering_app/screens/components/textStyles.dart';
import 'package:food_ordering_app/screens/shopRegScreen.dart';
import 'package:food_ordering_app/utils/dialogBoxes.dart';
import 'package:get/get.dart';
import 'customerRegScreen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  UserCredential? userCredential;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
 
    
    void newInstance(){
      Navigator.pop(context);
      emailController.text = '';
      passwordController.text = '';
  }
    
  Future loginAuth() async {
    if (_formKey.currentState!.validate())  {
        _formKey.currentState?.save(); 
    
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       showAlertDialog(context, "Login Failed","Please Enter a Correct Email Address",newInstance);     
      } else if (e.code == 'wrong-password') {
       showAlertDialog(context, "Login Failed","Please Enter the Correct Password",newInstance);
        setState(() {
         isLoading= false;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }
  }

   void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var statement1 = FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot1) {
      if (documentSnapshot1.exists) {
        Get.off(() =>  const CustomerDashboard());
      } else {
        var statement2 = FirebaseFirestore.instance
            .collection('shopData')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot2) {
          if (documentSnapshot2.exists) {
            Get.off(() => const ShopDashboard());
          } else {
            print('Document does not exist on the database');
          }
        });
      }
    });
  }                       

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; 
    return Scaffold(
      body:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.1,),
              const Center(
                child: Text("Welcome Back",style: TextStyle(fontSize: 24,color: kPrimaryColor,fontWeight: FontWeight.bold))
              ),
              SizedBox(height: height*0.08,),
              const FieldLabel(text: "Email"),
              TextFieldForm(hintText: 'abc@gmail.com', textEditingController: emailController,isObscure: false,textFieldType: 'Email',),
              const FieldLabel(text: "Password"),
              TextFieldForm(hintText: '*********', textEditingController: passwordController,isObscure: true,textFieldType: 'Password',),      
              SizedBox(height: height*0.075,),
              Center(
                child: SimpleButton(
                  btnColor: kPrimaryColor,
                  btntxtColor: Colors.white,
                  press: () { 
                   loginAuth();
                },
                text: 'Login',
                ),
              ),
              SizedBox(height: height*0.05,),
                const Center(
                  child: Text("If you don't have an account,",
                  style: TextStyle(color: Colors.black,fontSize: 18)),
                ),
                SizedBox(height: height*0.03,),
               Center(
                child: SimpleButton2(
                  btnColor: Colors.white,
                  btntxtColor: kPrimaryColor,
                  press: () { 
                     Get.off(() => const CustomerRegisterScreen());
                },
                text: 'Customer Registration',
                ),
              ),
              SizedBox(height: height*0.03,),
               Center(
                child: SimpleButton2(
                   btnColor: Colors.white,
                  btntxtColor: kPrimaryColor,
                  press: () { 
                  Get.off(() => const ShopRegisterScreen());
                },
                text: 'Shop Registration',
                ),
              ),
               ]),
            ),
        ),
      );  
  }
}