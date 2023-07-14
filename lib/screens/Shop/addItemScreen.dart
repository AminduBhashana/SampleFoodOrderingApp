import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/Shop/shopDashboard.dart';
import 'package:food_ordering_app/screens/components/textFieldForm.dart';
import 'package:food_ordering_app/screens/components/textStyles.dart';
import 'package:food_ordering_app/utils/dialogBoxes.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  String? imageUrl;

 Future<void> addItem() async {
  User? user = FirebaseAuth.instance.currentUser;  
  try {
    if (imageFile != null) {
      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('item_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(imageFile!);

      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('shopItems')
          .doc(user!.uid)
          .collection('items') 
          .add({
        'name': nameController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'imageUrl': imageUrl,
      });
    } else {
      await FirebaseFirestore.instance
          .collection('shopItems')
          .doc(user!.uid)
          .collection('items')
          .add({
        'name': nameController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
      });
    }
  } catch (e) {
    print('Error: $e');
  }

 }

Future<void> pickImage() async {
  final ImagePicker _imagePicker = ImagePicker();

  try {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      }
    });
  } catch (e) {
    print('Error: $e');
  }
}

void clearFields(){
  nameController.text = '';
  descriptionController.text = '';
  priceController.text = '';
}

void backScreen(){
    Get.to(()=> const ShopDashboard());
  }
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; 
    final width = MediaQuery.of(context).size.width;  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
       title:  const Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400)),
        toolbarHeight: 80,        
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:    Column(
                crossAxisAlignment: CrossAxisAlignment.start,           
                children: [
                  SizedBox(height: height*0.025,),
                   Center(
                    child: Text("Add Items".toUpperCase(),style: const TextStyle(fontSize: 24,color: kPrimaryColor,fontWeight: FontWeight.bold))
                  ),
                  SizedBox(height: height*0.03,),
                  const FieldLabel(text: "Item Name"),
                  TextFieldForm(hintText: '', textEditingController: nameController,isObscure: false,textFieldType: 'Itemname',),
                  const FieldLabel(text: "Description"),
                  TextFieldForm(hintText: '', textEditingController: descriptionController,isObscure: false,textFieldType: 'Description',),
                  const FieldLabel(text: "Price"),
                  TextFieldForm(hintText: '', textEditingController: priceController,isObscure: false,textFieldType: 'Price',),
                  SizedBox(height: height*0.04,),
                  Center(
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(0.5 * width, 50),
                      side: const BorderSide(
                        width: 2.0,
                        color: kPrimaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Pick Image",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                  SizedBox(height: height*0.05,),
                  Center(
                  child: ElevatedButton(
                    onPressed: () {                     
                      addItem();
                      showAlertDialog(context, "Adding Item","Your Item has been successfully listed", backScreen);               
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        fixedSize: Size(0.5 * width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        foregroundColor: Colors.white),
                    child: const Text(
                      'Add Item',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}