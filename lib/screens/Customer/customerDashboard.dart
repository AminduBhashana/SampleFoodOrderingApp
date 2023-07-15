import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/Customer/foodItems.dart';
import 'package:food_ordering_app/screens/loginScreen.dart';
import 'package:get/get.dart';


class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  
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
    FirebaseFirestore.instance.collection('userData').doc(FirebaseAuth.instance.currentUser!.uid);
DocumentSnapshot docSnap = await authResult.get();
var data = docSnap.data() as Map<String, dynamic>;
_user = data['userName'];
setState(() {
  _user = _user;
});
}   
  String? userCountry;
  
  void getUserCountry() async{  
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .doc(user!.uid) 
      .get();    
    userCountry = userSnapshot['country'];
    setState(() {
      userCountry = userCountry;
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
    getUserCountry();
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
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shopData')
            .where('country', isEqualTo: userCountry)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot shop = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(shop['shopName']),
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodItems(
                          shopId: shop.id,
                          shopName: shop['name'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}