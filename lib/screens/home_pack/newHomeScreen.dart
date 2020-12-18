import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/services_screens/services_main.dart';

import 'newHomePage.dart';

class NewHomeScreen extends StatefulWidget {

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  String uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String storeType;
  String name;
  String store_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuid().whenComplete(() => getHomeScreen());
  }

  Future getuid() async {
    var firebaseUser = await _auth.currentUser;
    setState(() {
      uid = firebaseUser.uid;
    });
  }

  getHomeScreen() async {
    FirebaseFirestore.instance.collection('stores').doc(uid).get().then((
        DocumentSnapshot data) {
      setState(() {
        storeType = data.get('store_type').toString().toLowerCase();
        name = data.get('proprietor_name').toString();
        store_name=data.get('establishment_name').toString();
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height*1.07,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hello', style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20)),
                                Text(name ?? 'Loading...', style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 30)),
                              ],
                            )
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5,5,0,5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                if (uid != null) {
                                  if (storeType != null) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewHomePage(store_type: storeType,)));
                                  } else {
                                    Toast.show('Store Type data is null', context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                } else {
                                  Toast.show('User ID is null', context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.notifications,
                                  color: Colors.lightBlueAccent),
                              onPressed: null,
                            ),
                            SizedBox(width: 10,),
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images-na.ssl-images-amazon.com/images/I/91ldxI0EEnL._SL1500_.jpg')
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Your Owned Stores', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 85,
                    child: Container(
                      margin: EdgeInsets.only(right: 0, top: 0),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7nTXTue92M7ViJqRt-qvanji6UTwss9GK2A&usqp=CAU',
                              height: 120,
                              width: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 120,
                            width: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black26),
                            child: Text(
                              store_name??"loading...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 20,right: 10),
                //   height: 95,
                //   width: 300,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(18),
                //     image: new DecorationImage(
                //       image: AssetImage('images/background.jpg'),
                //       fit: BoxFit.cover
                //     )
                //   ),
                //   child: Column(),
                // ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    height: MediaQuery.of(context).size.height-230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
                            child: Text('Details Till Now...', style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(7, 9, 32, 1)
                                            .withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('1920', style: TextStyle(fontSize: 30,
                                        fontWeight: FontWeight.bold),),
                                    Image.asset('images/orders.png', height: 30,
                                      width: 30,),
                                    Text('No. of Orders', style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              Container(
                                height: 140,
                                width: 140,
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(7, 9, 32, 1)
                                            .withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('200', style: TextStyle(fontSize: 30,
                                        fontWeight: FontWeight.bold),),
                                    Image.asset(
                                      'images/employee.png', height: 30,
                                      width: 30,),
                                    Text('No. of Employees', style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(7, 9, 32, 1)
                                            .withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('50', style: TextStyle(fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                    Image.asset(
                                        'images/services.png', height: 30,
                                        width: 30),
                                    Text('No. of Services', style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 140,
                                height: 140,
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(7, 9, 32, 1)
                                            .withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('20.5 K', style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),),
                                    Image.asset(
                                      'images/money-bag.png', height: 30,
                                      width: 30,),
                                    Text('Revenue Made', style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


