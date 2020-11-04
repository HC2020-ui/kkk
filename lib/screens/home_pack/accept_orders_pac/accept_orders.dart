import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';

import 'accept_order_details.dart';

class AcceptOrders extends StatefulWidget {
  String store_type;
  String number;
  AcceptOrders({this.store_type, this.number});
  @override
  _AcceptOrdersState createState() => _AcceptOrdersState();
}

class _AcceptOrdersState extends State<AcceptOrders> {
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
                  child: Text("Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
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
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
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
                        title: Text('No Order', style: TextStyle(
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
                          title: Text('Order: ${index+1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
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
                                        text: '${data.get('order_name')}',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
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
                          onTap: () {
                            if (widget.store_type != null) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptOrderDetails(
                                        order: (index + 1).toString(),
                                        c_address: data.get('address'),
                                        c_name: data.get('order_name'),
                                        store_type: widget.store_type,
                                        number: widget.number,
                                      )));
                            }else{
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptOrderDetails(
                                        order: (index + 1).toString(),
                                        c_address: data.get('address'),
                                        c_name: data.get('order_name'),
                                        number: widget.number,
                                      )));
                            }
                          }
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
  }
}
