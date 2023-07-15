import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/Shop/addItemScreen.dart';
import 'package:food_ordering_app/screens/Shop/customListTile.dart';
import 'package:food_ordering_app/screens/loginScreen.dart';
import 'package:get/get.dart';

class ShopDashboard extends StatefulWidget {
  const ShopDashboard({super.key});

  @override
  State<ShopDashboard> createState() => _ShopDashboardState();
}

class _ShopDashboardState extends State<ShopDashboard> {
  
  String? _user;

  String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning' ;
  }
  else if (hour < 17) {
    return 'Afternoon';
  }
  else{
    return 'Evening';
  }
}

void getUserData() async {
DocumentReference authResult =
    FirebaseFirestore.instance.collection('shopData').doc(FirebaseAuth.instance.currentUser!.uid);
DocumentSnapshot docSnap = await authResult.get();
var data = docSnap.data() as Map<String, dynamic>;
_user = data['shopName'];
setState(() {
  _user = _user;
});
}

final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Get.offAll(()=>const LoginScreen());
  }

@override
  void initState() {
    super.initState();
    getUserData();
  }
  

  @override
  Widget build(BuildContext context) {
    var greet = greeting();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:  Text("Good $greet ! $_user",style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400)),
        toolbarHeight: 80,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout,size: 30,color: Colors.white,),
            tooltip: 'Log Out',
            onPressed: () {
              signOut();
            },
          ), 
        ], 
        ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed:() {
          Get.to(()=> const AddItemScreen());
        },
        child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shopItems')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot item = snapshot.data!.docs[index];
              Map<String, dynamic>? data = item.data() as Map<String, dynamic>?;

              if (data != null &&
                  data.containsKey('name') &&
                  data.containsKey('description') &&
                  data.containsKey('price') &&
                  data.containsKey('imageUrl')) {
                return customListTile(
                  name: data['name'],
                  description: data['description'],
                  price: data['price'],
                  imageUrl: data['imageUrl'],
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}

