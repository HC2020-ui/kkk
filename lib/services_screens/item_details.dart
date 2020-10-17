import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/services_screens/services_main.dart';

import 'editTimepage.dart';
import 'manage_appoints.dart';


class ItemDetail extends StatefulWidget {
  int appoint_no;
  String name;
  String address;
  String storename;
  ItemDetail({this.appoint_no,this.name,this.address,this.storename});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  String finalDate = '';
  int Itemcount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                                  Table(
                                      border: TableBorder.all(
                                        color: Colors.black26,
                                        width: 1,),
                                      children: [
                                        TableRow(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets
                                                    .all(12.0),
                                                child: TableCell(
                                                    verticalAlignment: TableCellVerticalAlignment
                                                        .middle,
                                                    child: Center(
                                                        child: Text(
                                                          'Sr. No.',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 18.0,),))),
                                              ),
                                              Padding(
                                                padding: EdgeInsets
                                                    .all(12.0),
                                                child: TableCell(
                                                    verticalAlignment: TableCellVerticalAlignment
                                                        .middle,
                                                    child: Center(
                                                        child: Text(
                                                          'Date',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .red),))),
                                              ),
                                              Padding(
                                                padding: EdgeInsets
                                                    .all(12.0),
                                                child: TableCell(
                                                    verticalAlignment: TableCellVerticalAlignment
                                                        .middle,
                                                    child: Center(
                                                        child: Text(
                                                          'Time',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .green),))),
                                              ),
                                            ]),
                                      ]
                                  ),
                                  Container(
                                    height: 300,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: ListView.builder(
                                      itemCount: Itemcount,
                                      itemBuilder: (context,
                                          index) {
                                        print(Itemcount.toString());
                                        print('hey');
                                        final DocumentSnapshot data = snapshot
                                            .data.docs[index];
                                        return Table(
                                          border: TableBorder.all(
                                            color: Colors.black26,
                                            width: 1,),
                                          children: [
                                            TableRow(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .all(12.0),
                                                    child: TableCell(
                                                        verticalAlignment: TableCellVerticalAlignment
                                                            .bottom,
                                                        child: Center(
                                                            child: Text(
                                                              (index + 1)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 18.0,),))),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .all(12.0),
                                                    child: TableCell(
                                                        verticalAlignment: TableCellVerticalAlignment
                                                            .bottom,
                                                        child: Center(
                                                            child: Text(
                                                              data
                                                                  .get(
                                                                  'date')
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 18.0,),))),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .all(12.0),
                                                    child: TableCell(
                                                        verticalAlignment: TableCellVerticalAlignment
                                                            .bottom,
                                                        child: Center(
                                                            child: Text(
                                                              data
                                                                  .get(
                                                                  'time')
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 18.0,),))),
                                                  ),
                                                ]),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Spacer(flex: 20,),
                                  Row(
                                    children: <Widget>[
                                      _buttonWidget(context, 90, 45,
                                          Colors.red, "Reject"),
                                      Spacer(),
                                      _buttonWidget(context, 136, 45,
                                          Colors.orangeAccent,
                                          "Change Timing"),
                                      Spacer(),
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
          else if (title == "Change Timing") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTime(appoint_no: widget.appoint_no,name: widget.name, address: widget.address,storename: widget.storename,)));
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

  Widget _switch_button(bool status) {
    return Container(
      padding: EdgeInsets.all(0),
      child: CustomSwitchButton(
        buttonHeight: 22.0,
        buttonWidth: 42.0,
        indicatorWidth: 15.0,
        backgroundColor: Colors.white,
        unCheckedColor: Colors.grey,
        animationDuration: Duration(milliseconds: 200),
        checkedColor: Colors.black,
        checked: status,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)
      ),
    );
  }
//   return Scaffold(
//     backgroundColor: Colors.grey,
//     appBar: AppBar(
//       backgroundColor: Colors.black54,
//       leading: new Container(
//         height: 25.0,
//         width: 25.0,
//         padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//         margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//         child: new Stack(
//           alignment: AlignmentDirectional.center,
//           children: <Widget>[
//             new Text('LOGO'),
//           ],
//         ),
//       ),
//       title: new Text('STORE NAME'),
//       centerTitle: true,
//       elevation: 0.0,
//     ),
//     body:  Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height:20.0),
//             Container(
//               color: Colors.white70,
//               child: ExpansionTile(
//                 title: Text(
//                   "Order Details",
//                   style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 children: <Widget>[
//                   ListTile(
//                     title: Text(
//                       'Order no. : ${widget.index+1}',
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                         'Customer Name: '
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                         'Home Appointments(YES/NO): '
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                         'Customer Address: '
//                     ),
//                   ),
//                   ListTile(
//                     title: Container(
//                       padding: const EdgeInsets.fromLTRB(0,15,0,15),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                       ), //             <--- BoxDecoration here
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//                         child: Text(
//                           "",
//                           style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: 20,),
//             Container(
//               color: Colors.white70,
//               child: ExpansionTile(
//                 title: Text('Required Services',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 children: [
//                   ExpansionTile(title: Text('Items',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87)),
//                     children: [
//                       ListTile(
//                         title: Text('Item 1'),
//                       ),
//                       ListTile(
//                         title: Text('Item 2'),
//                       ),
//                       ListTile(
//                         title: Text('Item 3'),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text("DATE",style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w600,
//                             )),
//                             SizedBox(width: 10,),
//                             Text(finalDate,style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             )),
//                           ],
//                         ),
//                         SizedBox(height: 20,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text("TIME",style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             )),
//                             SizedBox(width: 10,),
//                             Text('5:00 PM',style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             )),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: 80,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 RaisedButton(
//                   child: Text('Accept'),
//                   onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManageAppoints(widget.index,finalDate)));
//                   },
//                   color: Colors.lightGreenAccent,
//                 ),
//                 SizedBox(width: 10),
//                 RaisedButton(
//                   child: Text('Change Timing'),
//                   onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTime(widget.index)));
//                   },
//                   color: Colors.amber,
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             RaisedButton(
//               child: Text('Reject'),
//               onPressed: (){
//
//               },
//               color: Colors.redAccent,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
}
