import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/brands/add_service.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('services').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            // count of events
            final int eventCount = snapshot.data.docs.length ?? 0;
            if (eventCount == 0 || snapshot.hasError) {
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
                        child: Text("Add Services", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
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
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 12, 5, 20),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return new ListTile(
                          title: Text('Add Your Service', style: TextStyle(
                              color: Colors.white, fontSize: 20)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 30,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    AddServices()));
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
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              default:
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
                          child: Text("Services", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
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
                  body: new ListView.builder(
                      itemCount: eventCount,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        var width=MediaQuery.of(context).size.width;
                        return  Container(
                          decoration: boxDecoration(showShadow: true, radius: 10.0),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://howandwhat.net/wp-content/uploads/2017/08/Service.jpg',
                                    fit: BoxFit.fill,
                                    height: width * 0.2,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(data.get('Name'), style: TextStyle(fontSize: 17),),
                                      ],
                                    ),
                                    Text(data.get('Category'), style: TextStyle(color: Color(0xFF888888)),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(data.get('Brand')),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(data.get('Year'), style: TextStyle(color: Color(0xFF888888))),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                        // return new ListTile(
                        //   title: Text(
                        //       data.get('name').toString() ?? "Loading...",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 20)),
                        //   subtitle: Text(
                        //       data.get('category') ?? "Loading...",
                        //       style: TextStyle(fontWeight: FontWeight.bold)),
                        //   trailing: Text(
                        //       'view', style: TextStyle(color: Colors.red),
                        //       textAlign: TextAlign.end),
                        //   onTap: () {
                        //     // _showDialog(data);
                        //   },
                        //   onLongPress: () {
                        //     Navigator.pop(context);
                        //     deleteDialogbox(data);
                        //   },
                        // );
                      }
                  ),
                  floatingActionButton: new FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              AddServices()));
                    },
                    backgroundColor: Color.fromRGBO(93, 187, 99, 1),
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
          title: new Text(
            "Service Details", style: TextStyle(color: Colors.grey),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: 'category: ',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: data.get('category') ?? "loading...",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.grey),
                      )
                    ]
                ),
              ),
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddServices()));
              },
            ),
            new FlatButton(
              child: new Text("Delete"),
              onPressed: () async {
                await deleteDialogbox(data);
                Toast.show("Your Product details has been removed!!!", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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
          title: new Text("Alert!!!", style: TextStyle(color: Colors.red)),
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
}

BoxDecoration boxDecoration({double radius = 10, Color color = Colors.transparent, Color bgColor = const Color(0xFFFFFFFF), var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow ? [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}