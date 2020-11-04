
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';

class ProfilePage extends StatefulWidget {
  String name;
  String location;
  String phone;
  String vendor_type;
  String email;
  String storename;
  ProfilePage({this.name,this.email,this.phone,this.vendor_type,this.location,this.storename});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            color: Color.fromRGBO(255, 117, 117, 1),
          ),
          child: Row(
            children: <Widget>[
              Text("LOGO", style: TextStyle(color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),),
              Spacer(flex: 2,),
              Align(
                  alignment: Alignment.center,
                  child:widget.storename!=null ?Text(widget.storename, style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
              )
                :Text("Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)
        )
              ),
              Spacer(flex: 3,),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Details', style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20),),
            SizedBox(height: 20,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Photo', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images-na.ssl-images-amazon.com/images/I/91ldxI0EEnL._SL1500_.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Text('Edit', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    Text('Delete', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name' ,style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.name!=null ?widget.name:'No value', style: TextStyle(color: Colors.black),),
                      SizedBox(width: 10,),
                      Text('Edit', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone No.', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.phone!=null?widget.phone:'No value', style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    Text('Edit', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.phone!=null?widget.email:'No value', style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    Text('Edit', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Location', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:230,
                          child: SingleChildScrollView(child: Text(widget.location!=null?widget.location:'No value', style: TextStyle(color: Colors.black),))),
                      Text('Edit', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vendor Type', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.vendor_type!=null?widget.vendor_type:'No value', style: TextStyle(color: Colors.black),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
