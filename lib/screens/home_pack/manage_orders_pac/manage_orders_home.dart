import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/manage_orders_pac/delivered_details.dart';
// import 'package:winkl/screens/home_pack/accept_orders_pac/acc_orders_list_item.dart';
import 'package:winkl/screens/home_pack/manage_orders_pac/manage_orders_delivered.dart';

class ManageOrdersHome extends StatefulWidget {
  String store_type;
  ManageOrdersHome({this.store_type});
  @override
  _ManageOrdersHomeState createState() => _ManageOrdersHomeState();
}

class _ManageOrdersHomeState extends State<ManageOrdersHome> {

  String uid;
  String store_name;

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:     Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(93, 187, 99, 1),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(store_name!=null?store_name:"Store Name", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
          // child: Row(
          //   children: <Widget>[
          //     // Text("LOGO", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
          //     // Spacer(flex: 2,),
          //
          //   ],
          // ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo_app.png",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
            color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 234,
                    decoration: BoxDecoration(
                        color: Font_Style().primaryColor, borderRadius: BorderRadius.circular(10)),
                    height: 48,
                    child: Center(
                      child: Text(
                          "Manage Orders",
                          style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  Spacer(flex: 7,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                      height: 45,
                      child: Center(
                        child: Text(
                            "Pending Orders",
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    height: 200.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: 'pending').snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          final int count = snapshot.data.docs.length;
                          if (snapshot.data.docs == null) {
                            return Center(child: CircularProgressIndicator());
                          }
                          else if (count == 0) {
                            return Container(
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return new Text('No Pending Order !!!', style: TextStyle(
                                        color: Colors.black, fontSize: 20));
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
                                child: ListView.separated(
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
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot data = snapshot.data
                                        .docs[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            data.get('imageUrl').toString()),
                                      ),
                                      title: Text('Order: ${index + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
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
                                                        fontWeight: FontWeight
                                                            .normal,
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
                                                    text: '${data.get(
                                                        'address')}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .normal,
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
                                                    text: '${data.get(
                                                        'distance')} kms',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ]
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Text('view >', style: TextStyle(
                                              color: Colors.grey)),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                DeliveredDetails(order: (index+1).toString(),c_address: data.get('address'),c_name: data.get('order_name'),event: "pending",store_name: store_name,)));
                                      },
                                    );
                                  },
                                ),
                              );
                          }
                        }
                      ),
                    ),
                  ),
                  Spacer(flex: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                      height: 45,
                      child: Center(
                        child: Text(
                            "Delivered Orders",
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    height: 200.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: 'completed').snapshots(),
                          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                            final int count = snapshot.data.docs.length;
                            if (snapshot.data.docs == null) {
                              return Center(child: CircularProgressIndicator(),);
                            }
                            else if (count == 0) {
                              return Container(
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return new Text('No Delivered Order', style: TextStyle(
                                          color: Colors.black, fontSize: 20));
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
                                  child: ListView.separated(
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
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot data = snapshot.data
                                          .docs[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              data.get('imageUrl')),
                                        ),
                                        title: Text('Order: ${index + 1}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
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
                                                          fontWeight: FontWeight
                                                              .normal,
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
                                                      text: '${data.get(
                                                          'address')}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal,
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
                                                      text: '${data.get(
                                                          'distance')} kms',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Text('view >', style: TextStyle(
                                                color: Colors.grey)),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  DeliveredDetails(order: (index+1).toString(),c_address: data.get('address'),c_name: data.get('order_name'),event: "delivered",store_name: store_name,)));
                                        },
                                      );
                                    },
                                  ),
                                );
                            }
                          }
                      ),
                    ),
                  ),
                  Spacer(flex: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){

        },
        child: Container(
          width: 234,
          decoration: BoxDecoration(
              color: Font_Style().primaryColor, borderRadius: BorderRadius.circular(30)),
          height: 48,
          child: Center(
            child: Text(
                "Login",
                style:TextStyle(color: Colors.white, fontSize: 19)
            ),
          ),
        ),
      ),
    );
  }
}
