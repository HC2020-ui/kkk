import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';

import 'item_details.dart';

class AcceptAppoints extends StatefulWidget {
  String storename;
  AcceptAppoints({this.storename});
  @override
  _AcceptAppointsState createState() => _AcceptAppointsState();
}

class _AcceptAppointsState extends State<AcceptAppoints> {
  int item_num=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:      Container(
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
          margin: EdgeInsets.only(top: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('customers').snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              final int count=snapshot.data.docs.length;
              if(snapshot.data==null){
                return Center(child: CircularProgressIndicator(),);
              }
              else if (count==0) {
                return Container(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: Text('No Appointments', style: TextStyle(
                            color: Colors.white, fontSize: 20)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 30,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                        },
                      );
                    },
                    padding: EdgeInsets.all(10),
                  ),
                );
              }
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return Container(
                    child: new ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                        child: Divider(
                          thickness: 0.7,
                          color: Color.fromRGBO(3, 90, 166, 1),
                        ),
                      ),
                      physics: ClampingScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (context,index){
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://web.aflia.net/wp-content/uploads/2018/12/dp_placeholder-275x300.jpg'),
                          ),
                          title: Text('Appointment: ${index+1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          subtitle: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              RichText(
                                text: TextSpan(
                                    text: 'Customer Name: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${data.get('name')}',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 5,),
                              RichText(
                                text: TextSpan(
                                    text: 'Address: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${data.get('address')}',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
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
                                    text: 'Distance: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 10),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${data.get('distance')} kms',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 10),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text('view >',style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetail(storename:widget.storename,appoint_no: (index+1),name: data.get('name'),address: data.get('address'))));
                          },
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
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
    //       elevation: 1.0,
    //       centerTitle: true,
    //     ),
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Center(
    //           child: new Container(
    //             margin: EdgeInsets.all(20),
    //             padding: EdgeInsets.all(10),
    //             child: Text("Accept Appointments",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
    //           ),
    //         ),
    //         SizedBox(height: 20,),
    //         Container(
    //           height: MediaQuery.of(context).size.height*0.6,
    //           margin: EdgeInsets.all(10),
    //           child: new ListView.builder(
    //             itemCount:10,
    //             itemBuilder: (BuildContext context,int index){
    //               return Container(
    //                 child: InkWell(
    //                   child: Card(
    //                     color: Colors.white70,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text('Order no.: ${index+1}',style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),),
    //                               SizedBox(height: 5,),
    //                               Text('Customer Name: ',style: TextStyle(color: Colors.blue),),
    //                               SizedBox(height: 5,),
    //                               Text('Customer Address: ',style: TextStyle(color: Colors.blue),),
    //                             ],
    //                           ),
    //                         ),
    //                         Column(
    //                           children: [
    //                             Padding(
    //                               padding: const EdgeInsets.all(8.0),
    //                               child: Text('5:00 PM',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
    //                             ),
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                     elevation: 2,
    //                   ),
    //                   onTap: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetail(index)));
    //                   },
    //                 ),
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
