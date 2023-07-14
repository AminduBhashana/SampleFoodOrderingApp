import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/components/simpleBtn.dart';
import 'package:food_ordering_app/screens/components/textFieldForm.dart';
import 'package:food_ordering_app/screens/components/textStyles.dart';
import 'package:food_ordering_app/screens/loginScreen.dart';
import 'package:food_ordering_app/utils/dialogBoxes.dart';
import 'package:get/get.dart';
import '../Theme/Constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  
  @override
  void initState() {
     getWorldData();
    super.initState();
  }

  final _formKey =  GlobalKey<FormState>();
  UserCredential? userCredential;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isChecked = false; 
  bool isLoading = false;

  //Country Dropdown
  String url = "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json";
  var _countries = [];
  String? country;
  bool isCountrySelected = false;

  Future getWorldData()async{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
    var jsonResponse = convert.jsonDecode(response.body);

     setState(() {
      _countries = jsonResponse;
    });
 } 
  } 
  
  void changeScreen(){
     Get.off(() => const LoginScreen());
  }

  void retainScreen(){
    Navigator.pop(context);
  }

   Future sendData() async {
    bool flag = false;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (!isChecked) {
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Account Creation Error","You have to agree for our Terms of service.",retainScreen);
        flag = true;
        setState(() {
            isLoading = false;
        });
      }
      if (!flag) {
        try {      
          userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(userCredential!.user!.uid)
              .set({
            "userName": usernameController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "country": country,
            "userid": userCredential!.user!.uid,
          });
           setState(() {
            isLoading = true;
          });          
          if (isLoading) {
            const CircularProgressIndicator();
            // ignore: use_build_context_synchronously
            showAlertDialog(context, "Account Creation",
                "Your Account has been successfully created", changeScreen);
          }   
        } on FirebaseAuthException catch (e) {
          setState(() {
              isLoading = false;
          });
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("The provided password is too weak."),
              ),
            );
             
          } else if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("This email has been already Used"),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      }
    }else{
      setState(() {
        isLoading = false;
      });
    }
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
              SizedBox(height: height*0.075,),
              const Center(
                child: Text("Register As a Customer",style: TextStyle(fontSize: 24,color: kPrimaryColor,fontWeight: FontWeight.bold))
              ),
              SizedBox(height: height*0.05,),
              const FieldLabel(text: "Username"),
              TextFieldForm(hintText: 'Username', textEditingController: usernameController,isObscure: false,textFieldType: 'Username',),
              const FieldLabel(text: "Email"),
              TextFieldForm(hintText: 'abc@gmail.com', textEditingController: emailController,isObscure: false,textFieldType: 'Email',),
              const FieldLabel(text: "Password"),
              TextFieldForm(hintText: '*********', textEditingController: passwordController,isObscure: true,textFieldType: 'Password',),
              const FieldLabel(text: "Country"),
              if (_countries.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            Card(
              margin:  EdgeInsets.symmetric(horizontal: 16,vertical: height*0.005),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side:  const BorderSide(
                  width: 2.0,
                  color: kPrimaryColor,),
                  borderRadius: BorderRadius.circular(kBorderRadius)),        
              child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 16,vertical: height*0.01),
                child: DropdownButton<String>(
                    underline: Container(),
                    hint: const Text("Select Country"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isDense: true,
                    isExpanded: true,
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    items: _countries.map((ctry) {
                      return DropdownMenuItem<String>(
                          value: ctry["name"], child: Text(ctry["name"]));
                    }).toList(),
                    value: country,
                    onChanged: (value) {
                      setState(() {
                        country = value!;
                        for (int i = 0; i < _countries.length; i++) {
                          if (_countries[i]["name"] == value) {}
                        }
                        isCountrySelected = true;
                      });
                    }),
              ),
            ),
              ListTile(
              title: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "By signing up, I understand and agree to \n",
                  style: TextStyle(color: Colors.black)
                ),
                TextSpan(
                    text: "Terms of Service.",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ))
              ])),
              leading: Checkbox(
                value: isChecked,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              )),
              SizedBox(height: height*0.05,),
              Center(
                child: SimpleButton(
                  btnColor: kPrimaryColor,
                  btntxtColor: Colors.white,
                  press: () {
                   sendData();                                                                
                },
                text: 'Create an Account',
                ),
              ),
              SizedBox(height: height*0.05,),
              InkWell(
                mouseCursor: MaterialStateMouseCursor.clickable,
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                hoverColor: Colors.white,
                splashColor: Colors.white,
                child: const Center(
                  child: Text("I already have an account",
                  style: TextStyle(color: kPrimaryColor,fontSize: 18,),),
                ),                    
              ),
            ]),
        ),
      ));    
  }
}