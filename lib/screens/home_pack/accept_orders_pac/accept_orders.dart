import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';

import 'acc_orders_list_item.dart';

class AcceptOrders extends StatefulWidget {
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
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                        child: Divider(
                          thickness: 0.7,
                          color: Color.fromRGBO(3, 90, 166, 1),
                        ),
                      ),
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 30,
                      itemBuilder: (context, i) {
                        return AccOrdersListItem();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
