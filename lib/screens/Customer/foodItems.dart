import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Theme/Constants.dart';
import 'package:food_ordering_app/screens/Shop/customListTile.dart';

class FoodItems extends StatefulWidget {
  final String shopId;
  final String shopName;

    const FoodItems({Key? key, required this.shopId, required this.shopName})
      : super(key: key);

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {

  @override
  Widget build(BuildContext context) {
    print(widget.shopId);
    return Scaffold(
      appBar: AppBar(
      backgroundColor:kPrimaryColor,
      title :  Text(widget.shopName,style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,)
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shopItems')         
            .doc(widget.shopId)
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