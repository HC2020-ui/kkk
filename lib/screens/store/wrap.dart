import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/store/store_form.dart';

class Wrapper2 extends StatefulWidget {
  String id;
  String phone;
  Wrapper2({this.id,this.phone});

  @override
  _Wrapper2State createState() => _Wrapper2State();
}

class _Wrapper2State extends State<Wrapper2> {
  var firestore=FirebaseFirestore.instance;
  bool exist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async{
    final snapShot = await FirebaseFirestore.instance.collection('stores').doc(widget.id).get();
    if (snapShot == null || !snapShot.exists) {
      setState(() {
        exist=false;
      });
    }else{
      setState(() {
        exist=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(exist==null){
      return Scaffold(body: Container(child: Center(child: CircularProgressIndicator())));
    }
    return exist? Home(id: widget.id): StoreForm(id: widget.id,Phone: widget.phone,);
  }
}

