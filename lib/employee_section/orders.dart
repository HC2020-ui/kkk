import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept_order_details.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  StreamBuilder<QuerySnapshot>(
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
              return Scaffold(
                appBar: AppBar(
                  title: Text('Assigned Orders'),
                ),
                body: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                      if(data.get('status')=='delivered') {
                        return Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://web.aflia.net/wp-content/uploads/2018/12/dp_placeholder-275x300.jpg'),
                            ),
                            title: Text('Order: ${index + 1}', style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                            subtitle: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              fontWeight: FontWeight.normal,
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
                                          text: '${data.get('address')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
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
                                          text: '${data.get('distance')} kms',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text('${data.get('status')}',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            onTap: () {
                              Toast.show('Order Delivered', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                            },
                          ),
                        );
                      }else{
                        return Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://web.aflia.net/wp-content/uploads/2018/12/dp_placeholder-275x300.jpg'),
                            ),
                            title: Text('Order: ${index + 1}', style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                            subtitle: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              fontWeight: FontWeight.normal,
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
                                          text: '${data.get('address')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
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
                                          text: '${data.get('distance')} kms',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text('${data.get('status')}',
                                    style: TextStyle(color: Colors.redAccent)),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptOrderDetails(
                                        order: (index + 1).toString(),
                                        c_address: data.get('address'),
                                        c_name: data.get('name'),
                                        employee: 'yes',
                                      )));
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
