import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/dark_theme/dart_theme_provider.dart';
// import 'package:winkl/screens/intro/intro.dart';
import 'package:winkl/settings_page.dart';

import 'accept_order_details.dart';

class AcceptOrders extends StatefulWidget {
  String store_type;
  String number;
  AcceptOrders({this.store_type, this.number});
  @override
  _AcceptOrdersState createState() => _AcceptOrdersState();
}

class _AcceptOrdersState extends State<AcceptOrders> {

  String uid;
  String store_name;
  String store_type;
  String latitude;
  String longitude;
  String number;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuid().whenComplete(() => getdata());
  }

  Future getuid() async{
    var firebaseuser=FirebaseAuth.instance.currentUser;
    setState(() {
      uid=firebaseuser.uid;
    });
  }

  getdata() async{
    await FirebaseFirestore.instance.collection('stores').doc(uid)
        .get().then((DocumentSnapshot data) {
      setState(() {
        store_name=data.get('establishment_name');
        store_type=data.get('store_type');
        number=data.get('phone');
        latitude=data.get('latitude');
        longitude=data.get('longitude');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(
              top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(93, 187, 99, 1),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(store_name==null?'Loading...':store_name, style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo_app.png",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage(store_name, latitude,longitude)));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              final int count = snapshot.data.docs.length;
              if (snapshot.data.docs.isEmpty) {
                return Center(child: CircularProgressIndicator(),);
              }
              else if (count == 0) {
                return Container(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: Text('No Order', style: TextStyle(
                            color: Colors.white, fontSize: 20)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 30,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                         Toast.show('No orders', context);
                        },
                      );
                    },
                    padding: EdgeInsets.all(10),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return Container(
                    child: new ListView.separated(
                      separatorBuilder: (context, index) =>
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 10.0),
                            child: Divider(
                              thickness: 0.7,
                              color: Color.fromRGBO(3, 90, 166, 1),
                            ),
                          ),
                      physics: ClampingScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  data.get('imageUrl')),
                            ),
                            title: Text('Order: ${index + 1}', style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                            subtitle: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                RichText(
                                  text: TextSpan(
                                      text: 'Customer Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${data.get('order_name')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 5,),
                                RichText(
                                  text: TextSpan(
                                      text: 'Address: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${data.get('address')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'Distance: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 10),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${data.get('distance')} kms',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text('view >',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            onTap: () {
                              if (store_type != null) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        AcceptOrderDetails(
                                          order: (index + 1).toString(),
                                          c_address: data.get('address'),
                                          c_name: data.get('order_name'),
                                          store_type: store_type,
                                          number: number,
                                          storename: store_name,
                                        )));
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        AcceptOrderDetails(
                                          order: (index + 1).toString(),
                                          c_address: data.get('address'),
                                          c_name: data.get('order_name'),
                                          number: number,
                                          storename: store_name,
                                        )));
                              }
                            }
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
