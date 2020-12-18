
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/dark_theme/dart_theme_provider.dart';
import 'package:winkl/screens/store/brands/brandsList.dart';
import 'package:winkl/screens/store/product_search.dart';

import '../../store/add_product.dart';

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
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(
              top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(93, 187, 99, 1),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text('Products', style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo_app.png",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort,color: Colors.black),
            color: Colors.black26,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BPList()));
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            // count of event
            int eventCount=snapshot.data.docs.length??0;
            if(snapshot.data.docs == null) return Container(child: Center(child: CircularProgressIndicator()));
            else if (eventCount==0 || snapshot.hasError) {
              return SafeArea(
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
              );
            }
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              default:
                return Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.grey.shade200
                  ),
                  child: new GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(eventCount, (index) {
                      final DocumentSnapshot data = snapshot.data.docs[index];
                      return InkWell(
                        onTap: (){
                          _showDialog(data);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeInImage.assetNetwork(
                              height: 75,
                              width: 75,
                              placeholder: 'images/15256.jpg',
                              image: data.get('imageUrl'),
                              imageScale: 1.2,
                            ),
                            Text(capitalize(data.get('name')), style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                            Text(capitalize(data.get('brand_name')), style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                            Text(data.get('selling_price'), style: TextStyle(color: themeChange.darkTheme?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 20))
                          ],
                        ),
                      );
                    }),
                  ),
                );
            }
          }),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color.fromRGBO(93, 187, 99, 1),
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct('add')));
        },
      ),
    );
  }

  void _showDialog(DocumentSnapshot data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Product Details",style: TextStyle(color: Colors.grey),),
          content: SingleChildScrollView(
            child: Column(
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
                Navigator.of(context).pop();
                await deleteDialogbox(data);
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