

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:winkl/screens/store/add_product.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  @override
  String name = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  bool isEmpty = false;
  var searchText = "";
  bool isLoadingMoreData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15,15,0,15),
                    padding: const EdgeInsets.all(3.0),
                    width: MediaQuery.of(context).size.width-110,
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.search,color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear,color: Colors.grey,),
                          onPressed: (){
                            searchController.clear();
                          },
                        ),
                        hintText: 'Search',
                      ),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                  ),
                  Container(
                      width: 90,
                      child: FlatButton(
                        child: Text('Category'),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SerachByCategory()));
                        },
                      )
                  )
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,15),
                  height: 500,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance
                        .collection('products')
                        .where("name", isEqualTo: name)
                        .snapshots()
                        : FirebaseFirestore.instance.collection("products").snapshots(),
                    builder: (context, snapshot) {
                      int count= snapshot.data.docs.length;
                      if(count==0){
                        return ListTile(
                          title: Text('Add Yourself', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800)),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddProduct('add')));
                          },
                        );
                      }
                      return (snapshot.connectionState == ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          if(data.get('addedby').toString()=='admin') {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              margin: EdgeInsets.fromLTRB(5, 15, 15,0),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 65.0,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover, image: NetworkImage(data.get('imageUrl'))),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(capitalize(data.get('name')??"Connection Error"), style: TextStyle(fontWeight: FontWeight.w900,color: Colors.grey.shade600,fontSize: 15)),
                                        Text(capitalize(data.get('category').toString()??"Connection Error"), style: TextStyle(color: Colors.grey,fontSize: 12),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else{
                            return Container();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//   return new
// }

}

class SerachByCategory extends StatefulWidget {
  @override
  _SerachBycategoryState createState() => _SerachBycategoryState();
}

class _SerachBycategoryState extends State<SerachByCategory> {

  String category="";
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15,15,0,15),
                    padding: const EdgeInsets.all(3.0),
                    width: MediaQuery.of(context).size.width-100,
                    child: TextField(
                      controller: categoryController,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                          ),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.search,color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear,color: Colors.grey,),
                            onPressed: (){
                              categoryController.clear();
                            },
                          ),
                          hintText: 'Search',
                      ),
                      onChanged: (val) {
                        setState(() {
                          category = val;
                        });
                      },
                    ),
                  ),
                  Container(
                      width: 80,
                      child: FlatButton(
                        child: Text('Name'),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProductSearch()));
                        },
                      )
                  )
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,15),
                  height: 500,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (category != "" && category != null)
                        ? FirebaseFirestore.instance
                        .collection('products')
                        .where("category", isEqualTo: category)
                        .snapshots()
                        : FirebaseFirestore.instance.collection("products").snapshots(),
                    builder: (context, snapshot) {
                      int count= snapshot.data.docs.length;
                      if(count==0){
                        return ListTile(
                          title: Text('Add Yourself', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800)),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddProduct('add')));
                          },
                        );
                      }
                      return (snapshot.connectionState == ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          if(data.get('addedby').toString()=='admin') {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              margin: EdgeInsets.fromLTRB(5, 15, 15,0),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 65.0,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover, image: NetworkImage(data.get('imageUrl'))),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(capitalize(data.get('name')??"Connection Error"), style: TextStyle(fontWeight: FontWeight.w900,color: Colors.grey.shade600,fontSize: 15)),
                                        Text(capitalize(data.get('category').toString()??"Connection Error"), style: TextStyle(color: Colors.grey,fontSize: 12),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else{
                            return Container();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


