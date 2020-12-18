import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/add_brands.dart';
import 'package:winkl/screens/store/add_product.dart';

class BPList extends StatefulWidget {
  @override
  _BPListState createState() => _BPListState();
}

class _BPListState extends State<BPList> {
  TextEditingController editingController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('brands').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            // count of events
            final int eventCount = snapshot.data.docs.length;
            if(snapshot.data==null){
              return Center(child: CircularProgressIndicator());
            }
            else if (eventCount==0 || snapshot.hasError)
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 12, 5, 20),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context,index){
                        return new ListTile(
                          title: Text('Add Your Brand',style: TextStyle(color: Colors.white,fontSize: 20),),
                          trailing: Icon(Icons.arrow_forward_ios,size: 30,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.pop(context);
                          }
                        );
                      },
                      padding: EdgeInsets.all(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    width: double.infinity,
                    height: 100,
                  ),
                ),
              );
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      title: Container(
                        padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
                        height: 45.0,
                        width: 345.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(93, 187, 99, 1),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text("LOGO", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                            Spacer(flex: 2,),
                            Align(
                                alignment: Alignment.center,
                                child: Text("Brand List", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                            Spacer(flex: 3,),
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.search,color: Colors.black,),
                          color: Colors.black26,
                          onPressed: (){
                            
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
                    body: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 20),
                      height: MediaQuery.of(context).size.height-50,
                      width: double.infinity,
                      child: Expanded(
                        child: new ListView.builder(
                          shrinkWrap: true,
                            itemCount: eventCount ,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot data = snapshot.data.docs[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0,8,0,8),
                                child: new ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage('https://c.static-nike.com/a/images/w_1200,c_limit/bzl2wmsfh7kgdkufrrjq/seo-title.jpg'),
                                  ),
                                  title: Text(data.get('name').toString().toUpperCase()??"Loading...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                  trailing: Text('view',style: TextStyle(color: Colors.red),textAlign: TextAlign.end),
                                  onTap: (){
                                    Navigator.pop(context,data.get('name').toString());
                                  },
                                ),
                              );
                            }
                        ),
                      ),
                      ),
                    floatingActionButton: new FloatingActionButton(
                        elevation: 2.0,
                        child: new Icon(Icons.add),
                        backgroundColor: new Color.fromRGBO(93, 187, 99, 1),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBrands()));
                        }
                    ),
                  ),
                );
            }
          }),
    );
  }
}
