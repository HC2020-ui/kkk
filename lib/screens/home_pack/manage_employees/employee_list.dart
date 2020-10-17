import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/manage_employees/add_employees.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('employee').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            // count of events
            final int eventCount = snapshot.data.docs.length??0;
            if (eventCount==0 || snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Container(
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
                            child: Text("Add Employee", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
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
                    child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
                  ),
                ),
                body: SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 12, 5, 20),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return new ListTile(
                          title: Text('Add Employee', style: TextStyle(
                              color: Colors.white, fontSize: 20)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 30,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddEmployees()));
                          },
                        );
                      },
                      padding: EdgeInsets.all(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    height: 80,
                  ),
                ),
              );
            }
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              default:
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Container(
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
                              child: Text("Add Employee", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                          Spacer(flex: 3,),
                        ],
                      ),
                    ),
                    actions: [
                      // IconButton(
                      //   icon: Icon(Icons.sort),
                      //   color: Colors.black26,
                      //   onPressed: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>BPList()));
                      //   },
                      // )
                    ],
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
                    ),
                  ),
                  body: new ListView.builder(
                      itemCount: eventCount ,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        return new ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://www.grocapitus.com/wp-content/uploads/placeholder-profile-male-500x500.png'),
                          ),
                          title: Text(data.get('name').toString()??"Loading...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.get('role')??"Loading...",style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 20,),
                              Text(data.get('phone')??"Loading...",style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                          trailing: Text('view',style: TextStyle(color: Colors.red),textAlign: TextAlign.end),
                          onTap: (){
                            _showDialog(data);
                          },
                          onLongPress: (){
                            Navigator.pop(context);
                            deleteDialogbox(data);
                          },
                        );
                      }
                  ),
                  floatingActionButton: new FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: (){
                      _showdialogbox();
                    },
                  ),
                );
            }
          }),
    );
  }

  void _showDialog(DocumentSnapshot data) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Employee Details",style: TextStyle(color: Colors.grey),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                    placeholder: "images/placeholder.png",
                    image: 'https://www.grocapitus.com/wp-content/uploads/placeholder-profile-male-500x500.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Email: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: data.get('email')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
                      )
                    ]
                ),
              ),
              Spacer(flex: 5,),
              // RichText(
              //   text: TextSpan(
              //       text: 'size: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: data.get('size')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
              //         ),
              //       ]
              //   ),
              // ),
              // Spacer(flex: 5,),
              // RichText(
              //   text: TextSpan(
              //       text: 'color: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: data.get('color')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
              //         )
              //       ]
              //   ),
              // ),
              Spacer(flex: 5,),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Edit"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEmployees()));
              },
            ),
            new FlatButton(
              child: new Text("Delete"),
              onPressed: () {
                Navigator.pop(context);
                deleteDialogbox(data);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteDialogbox(DocumentSnapshot data) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert!!!",style: TextStyle(color: Colors.red)),
          content: new Text("Do you want to delete this Product"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                await data.reference.delete();
                Navigator.pop(context);
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showdialogbox() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation",style: TextStyle(color: Colors.red)),
          content: new Text("Do you want to Add more Employess?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: ()  {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployees()));
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
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
