import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/brands/brandsList.dart';
import 'package:winkl/screens/store/product_search.dart';

import 'package:winkl/screens/home_pack/add_product.dart';

class ProductList extends StatefulWidget {
  String id;
  ProductList({this.id});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  bool dialVisible = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
                            child: Text("Add Product", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
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
                          title: Text('Add Your Product', style: TextStyle(
                              color: Colors.white, fontSize: 20)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 30,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddProduct("add",id: widget.id,)));
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
                              child: Text("Product List", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                          Spacer(flex: 3,),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.sort,color: Colors.black,),
                        color: Colors.black26,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BPList()));
                        },
                      )
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
                  body: new ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                      physics: ClampingScrollPhysics(),
                      itemCount: eventCount ,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        return SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 140,
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.get('brand_name').toString().toUpperCase(),style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
                                    SizedBox(height: 10,),
                                    Text(data.get('name').toString().toUpperCase(),style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.w800,fontSize: 20),),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Tooltip(
                                              child: Image.asset('images/rupee.png',
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.contain,
                                              ),
                                              message: 'Price',
                                            ),
                                            SizedBox(width: 5,),
                                            Text('${data.get('selling_price')}',style: TextStyle(color: Colors.red.shade600, fontSize: 15)),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Tooltip(
                                              child: Image.asset('images/boxes.png',
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.contain,
                                              ),
                                              message: 'Available Items',
                                            ),
                                            SizedBox(width: 5,),
                                            Text('${data.get('instock')}',style: TextStyle(color: Colors.red.shade600, fontSize: 15)),
                                          ],
                                        ),
                                        // Text('Rs. ${data.get('selling_price')}',style: TextStyle(color: Colors.green.shade600,fontSize: 15))
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(data.get('imageUrl'),
                                          ),
                                          radius: 30,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      IconButton(
                                        tooltip: 'Alter',
                                        iconSize: 30,
                                        icon: Icon(Icons.more_horiz),
                                        onPressed: (){
                                          _showDialog(data);
                                        },
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                        // return new ListTile(
                        //   leading: CircleAvatar(
                        //     backgroundImage: NetworkImage(data.get('imageUrl')),
                        //   ),
                        //   title: Text(data.get('name').toString()??"Loading...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        //   subtitle: Text(data.get('selling_price')??"Loading...",style: TextStyle(fontWeight: FontWeight.bold)),
                        //   trailing: Text('view',style: TextStyle(color: Colors.red),textAlign: TextAlign.end),
                        //   onTap: (){
                        //     _showDialog(data);
                        //   },
                        //   onLongPress: (){
                        //     Navigator.pop(context);
                        //     deleteDialogbox(data);
                        //   },
                        // );
                      }
                  ),
                  floatingActionButton: new FloatingActionButton(
                    splashColor: Colors.lightGreenAccent,
                    tooltip: 'Add Product Manually',
                    child: Icon(Icons.add),
                    elevation: 2.0,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct("add")));
                    },
                  ),
                  // floatingActionButton: SpeedDial(
                  //   tooltip: 'Click Me',
                  //   // animatedIcon: AnimatedIcons.menu_close,
                  //   animatedIconTheme: IconThemeData(size: 22.0),
                  //   child: Icon(Icons.add),
                  //   animatedIcon: AnimatedIcons.menu_close,
                  //   onOpen: () => print('OPENING DIAL'),
                  //   onClose: () => print('DIAL CLOSED'),
                  //   visible: dialVisible,
                  //   curve: Curves.easeInOutExpo,
                  //   children: [
                  //     SpeedDialChild(
                  //       child: Icon(Icons.adjust, color: Colors.white),
                  //       backgroundColor: Colors.deepOrange,
                  //       onTap: (){
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductFilter()));
                  //       },
                  //       label: 'Choose from Pre-Added Items',
                  //       labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  //       labelBackgroundColor: Colors.deepOrangeAccent,
                  //     ),
                  //     SpeedDialChild(
                  //       child: Icon(Icons.add_shopping_cart, color: Colors.white),
                  //       backgroundColor: Colors.green,
                  //       onTap: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct("add")));
                  //       },
                  //       label: 'Add Item Manually',
                  //       labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  //       labelBackgroundColor: Colors.green,
                  //     ),
                  //   ],
                  // ),
                );
            }
          }),
    );
  }

  void _showDialog(DocumentSnapshot data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Product Details",style: TextStyle(color: Colors.grey),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                    placeholder: "images/placeholder.png",
                    image: data.get('imageUrl'),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover
                ),
              ),
              SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  text: 'category: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                      text: data.get('category')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
                    )
                  ]
                ),
              ),
              SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                    text: 'Brand: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: data.get('brand_name')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
                      )
                    ]
                ),
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                    text: 'Details: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: data.get('details')??"loading...",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
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
              SizedBox(height: 10,),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Edit"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct("update",documentid:data.id)));
              },
            ),
            new FlatButton(
              child: new Text("Delete"),
              onPressed: () async {
                await deleteDialogbox(data);
                Toast.show("Your Product details has been removed!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
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

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
}