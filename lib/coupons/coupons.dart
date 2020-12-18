import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:strings/strings.dart';

class Coupons extends StatefulWidget {
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  String storename="";
  String uid="";
  TextEditingController coupon_controller= new TextEditingController();

  String coupon_code="";

  @override
  void initState() {
    super.initState();
    getid().whenComplete(() => getstorename());
  }

  Future getid() async {
    var firebaseinstance= await FirebaseAuth.instance.currentUser;
    setState(() {
      uid=firebaseinstance.uid;
    });
  }

  getstorename(){
    FirebaseFirestore.instance.collection('stores').doc(uid)
        .get().then((DocumentSnapshot) {
          setState(() {
            storename=DocumentSnapshot.get('establishment_name');
          });
    });
  }

  setcouponcode(){
    setState(() {
      coupon_code= coupon_controller.text+storename;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(25, 40, 25, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add the Coupon code:-', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    TextField(
                      controller: coupon_controller,
                      decoration: InputDecoration(
                        hintText: 'Enter Here',
                        hintStyle: TextStyle(
                          color: Colors.purple,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      onChanged: setcouponcode(),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/1.3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("coupons").snapshots(),
                  builder: (context, snap) { //just add this line
                    final item_count = snap.data.docs.length;
                    if (snap.data == null || item_count==0)
                      return Center(child: CircularProgressIndicator());
                    return ListView.builder(
                      itemCount: item_count,
                      itemBuilder: (context, index){
                        final DocumentSnapshot data= snap.data.docs[index];
                        return new Card(
                          color: Colors.blue,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1.5
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,15,0),
                                  child: Image.asset(
                                      'images/Discount_Sales.png',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.contain,
                                  )
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Dash(
                                    direction: Axis.vertical,
                                    length: 120,
                                    dashLength: 5,
                                    dashColor: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(capitalize(data.get('name')), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),),
                                        Text(capitalize(data.get('brand')), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(data.get('price')+' ₹', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 19)),
                                        SizedBox(width: 20,),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.bottomRight,
                                          child: Text(coupon_code, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
