import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/manage_orders_pac/delivered_details.dart';

class ManageAppointMents extends StatefulWidget {
  String storename;
  ManageAppointMents({this.storename});
  @override
  _ManageAppointMentsState createState() => _ManageAppointMentsState();
}

class _ManageAppointMentsState extends State<ManageAppointMents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:     Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(255, 117, 117, 1),
          ),
          child: Row(
            children: <Widget>[
              Text("LOGO", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              Spacer(flex: 2,),
              Align(
                  alignment: Alignment.center,
                  child: Text(widget.storename!=null?widget.storename:"Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
              Spacer(flex: 3,),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black,)),
      ),
      body: SafeArea(
        child: Container(
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
                        "Manage Appointments",
                        style: Font_Style().montserrat_Bold(Colors.white, 19)
                    ),
                  ),
                ),
                Spacer(flex: 7,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 234,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                    height: 48,
                    child: Center(
                      child: Text(
                          "Pending Appointments",
                          style: Font_Style().montserrat_Bold(Colors.white, 19)
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
                        stream: FirebaseFirestore.instance.collection('customers').snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          final int count = snapshot.data.docs.length;
                          if (snapshot.data == null) {
                            return Center(child: CircularProgressIndicator(),);
                          }
                          else if (count == 0) {
                            return Container(
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return new ListTile(
                                    title: Text('No Appointments', style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios, size: 30,),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
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
                                            'https://web.aflia.net/wp-content/uploads/2018/12/dp_placeholder-275x300.jpg'),
                                      ),
                                      title: Text('Appointment: ${index + 1}',
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
                                                    text: '${data.get('name')}',
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
                                                DeliveredDetails(order: (index+1).toString(),c_address: data.get('address'),c_name: data.get('name'),event: "pending",)));
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
                    width: 234,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                    height: 48,
                    child: Center(
                      child: Text(
                          "Completed Appointments",
                          style: Font_Style().montserrat_Bold(Colors.white, 19)
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
                        stream: FirebaseFirestore.instance.collection('customers').snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          final int count = snapshot.data.docs.length;
                          if (snapshot.data == null) {
                            return Center(child: CircularProgressIndicator(),);
                          }
                          else if (count == 0) {
                            return Container(
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return new ListTile(
                                    title: Text('No Appointments', style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios, size: 30,),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
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
                                            'https://web.aflia.net/wp-content/uploads/2018/12/dp_placeholder-275x300.jpg'),
                                      ),
                                      title: Text('Appointment: ${index + 1}',
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
                                                    text: '${data.get('name')}',
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
                                                DeliveredDetails(order: (index+1).toString(),c_address: data.get('address'),c_name: data.get('name'),event: "delivered",)));
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
                style: Font_Style().montserrat_Bold(Colors.white, 19)
            ),
          ),
        ),
      ),
    );
  }
}
