import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winkl/services_screens/services_main.dart';

class FinalScreen extends StatefulWidget {
  var index;

  FinalScreen(this.index);

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  String status="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: new Container(
          height: 25.0,
          width: 25.0,
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              new Text('LOGO'),
            ],
          ),
        ),
        title: new Text('STORE NAME'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Order No. : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 30,),
                Text(widget.index.toString(),style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Customer Name : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                Text("",style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Customer Address : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Bill Amount : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 30,),
                Text("00.00",style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Assign Expert ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 30,),
                Text(status,style: TextStyle(fontSize: 18,color: Colors.black)),
              ],
            ),
            SizedBox(height: 20,),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: RaisedButton(
                      child: Text('Save'),
                      color: Colors.lightGreenAccent,
                      onPressed: (){
                        setState(() {
                          status="saved";
                        });
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 120,
                    child: RaisedButton(
                      child: Text('Completed'),
                      onPressed: (){
                        showDialogBox("Appointment Accepted");
                        setState(() {
                          status="completed";
                        });
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 120,
                    child: RaisedButton(
                      child: Text('Cancel'),
                      color: Colors.red,
                      onPressed: (){
                        showDialogBox("Appoint got cancelled");
                        setState(() {
                          status="Cancel";
                        });
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            )
          ]
        )
      )
    );
  }
  showDialogBox(String msg){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Notification"),
          content: new Text(msg, style: TextStyle(fontStyle: FontStyle.italic),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
