import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept_order_details.dart';
import 'package:winkl/screens/home_pack/manage_orders_pac/delivered_details.dart';

class ManageOrdersDelivered extends StatefulWidget {
  @override
  _ManageOrdersDeliveredState createState() => _ManageOrdersDeliveredState();
}

class _ManageOrdersDeliveredState extends State<ManageOrdersDelivered> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeliveredDetails()),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        height: 70.0,
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Spacer(),
                Icon(Icons.account_circle, color: AppColors.orange, size: 50.0,),
                Spacer(),
              ],
            ),
            Spacer(flex: 1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Order No. :", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                Spacer(),
                Text("Customer Name :", style: TextStyle(color: Colors.red, fontSize: 14.0)),
                Spacer(),
                Text("Customer Address :", style: TextStyle(color: Color.fromRGBO(22, 162, 55, 1), fontSize: 14.0)),
              ],
            ),
            Spacer(flex: 4,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Distance : ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),),
                    Text("5 kms", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),
                  ],
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Text("view", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),),
                    SizedBox(width: 4.0,),
                    Icon(Icons.arrow_forward_ios, size: 14.0,)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
