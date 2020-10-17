import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/services_screens/services_main.dart';
import 'manage_appoints.dart';

class EditTime extends StatefulWidget {
  int appoint_no;
  String name;
  String address;
  String storename;
  EditTime({this.appoint_no,this.name,this.address, this.storename});
  @override
  _EditTimeState createState() => _EditTimeState();
}

class _EditTimeState extends State<EditTime> {
  DateTime _selectedDate=DateTime.now();
  var finalDate='';
  var time=TimeOfDay.now();
  int Itemcount;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('appointments')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Itemcount = snapshot.data.docs.length ?? 0;
          if (snapshot.data == null) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          else if (Itemcount == 0 || snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                      Spacer(flex: 2),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.storename!=null?widget.storename:"Store Name", style: TextStyle(color: AppColors
                              .white, fontSize: 16, fontWeight: FontWeight
                              .bold),)),
                      Spacer(flex: 3,),
                    ],
                  ),
                ),
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back, size: 24, color: Colors.black,)
                ),
              ),
              body: Center(
                child: Text('No Item'),
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            default:
              return Scaffold(
                backgroundColor: Colors.grey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Container(
                    padding: EdgeInsets.only(top: 7.0,
                        bottom: 7.0,
                        left: 10.0,
                        right: 10.0),
                    height: 45.0,
                    width: 345.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 117, 117, 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text("LOGO", style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),),
                        Spacer(flex: 2,),
                        Align(
                            alignment: Alignment.center,
                            child: Text("Store Name",
                              style: TextStyle(color: AppColors
                                  .white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),)),
                        Spacer(flex: 3,),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, size: 24,
                        color: Colors.black,)
                  ),
                ),
                body: SafeArea(
                    child: Center(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 10.0,
                              bottom: 10.0,
                              left: 18.0,
                              right: 18.0),
                          child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Appointment No. : ${widget
                                          .appoint_no}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight
                                              .w500),)),
                                Spacer(flex: 5,),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Name : ${widget
                                            .name}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.0))),
                                Spacer(flex: 5,),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Address : ${widget
                                            .address}",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                22, 162, 55, 1),
                                            fontSize: 14.0))),
                                Spacer(flex: 10,),
                                Text("Appointment Details",
                                  style: TextStyle(fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.orange),),
                                Spacer(flex: 10,),
                                Container(
                                  height: 300,
                                  color: Colors.white70,
                                  child:ListView.builder(
                                    itemCount: Itemcount,
                                    itemBuilder: (context,
                                        index) {
                                      print(Itemcount.toString());
                                      print('hey');
                                      final DocumentSnapshot data = snapshot
                                          .data.docs[index];
                                      return ListTile(
                                        title: Text(data.get('date'), style: TextStyle(color: Colors.red),),
                                        subtitle: Text(data.get('time') ,style: TextStyle(color: Colors.green),),
                                        onTap: (){
                                          _showDialogbox();
                                          if(finalDate!=''){
                                            updateDate(data.id);
                                          }
                                          if(time!=''){
                                            updateTime(data.id);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Text("Click on the date and time to customize...",
                                  textScaleFactor: 1.4,
                                  style: TextStyle(color: Colors.grey),),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    _buttonWidget(context, 90, 45,
                                        Colors.red, "Reject"),
                                    SizedBox(width: 20,),
                                    _buttonWidget(context, 90, 45,
                                        Colors.green, "Accept")
                                  ],
                                ),
                                Spacer(flex: 15,),
                              ]
                          ),
                        )
                    )
                )
              );
          }
        }
    );
  }

  Widget _buttonWidget(BuildContext context, double wid, double hei,
      Color color, String title) {
    return Container(
      child: InkWell(
        onTap: () {
          print(title);
          if (title == "Accept") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageAppoints(order: widget.appoint_no.toString(),c_name: widget.name,c_address: widget.address,storename: widget.storename,)));
          }
          else {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => Homepage()), (
                route) => false);
          }
        },
        child: Container(
          width: wid,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30)),
          height: hei,
          child: Center(
            child: Text(
                title,
                style: TextStyle(color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0)
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogbox() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Edit...",style: TextStyle(color: Colors.grey),),
          content: Text('Change your date and time for the appointments'),
          actions: [
            FlatButton(
              child: Text('Date'),
              onPressed: () async {
                await getDate();
                finalDate =
                    DateFormat.yMMMd().format(
                        _selectedDate);
              },
            ),
            FlatButton(
              child: Text('Time'),
              onPressed: () async {
                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  updateDate(String id) async{
    FirebaseFirestore.instance.collection('appointments')
        .doc(id).update({
      "date": finalDate,
    });
  }

  updateTime(String id) async{
    FirebaseFirestore.instance.collection('appointments')
        .doc(id).update({
      "time": time,
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    ).then((pickedDate){
      if(pickedDate==null){
        return ;
      }
      setState(() {
        _selectedDate=pickedDate;
      });
    });
  }

}
