import 'package:flutter/material.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/screen5.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/widgetslist.dart' as list;
import '../../../appBar.dart';

double iconSize = 20;

class ForthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Text('Order Number'),
              ),
              // buttonMaker(num: 1, color: Colors.grey, text: "Order No."),
              Divider(
                height: 4,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text('Customer Name'),
              ),
              Divider(
                height: 4,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      'Order Accepted',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Pick Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text("Order Details", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
              ),
              list.table(),
              Divider(
                height: 4,
              ),
              SingleChildScrollView(
                child: Row(
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        color: Colors.grey,
                        onPressed: () {},
                        child: Text('Total Bill Amount'),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text('26576'),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
              ),

        Center(
          heightFactor: 1.5,
          child: SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              elevation: 5,
              color: Colors.red,
              child: Text(
                'Ready for Pick Up',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FifthScreen();
                    },
                  ),
                );
              },
            ),
          ),
        ),
//              buttons('Picked by Customer', Colors.cyan),
//              buttons('Cancel Order', Colors.red),
            ],
          ),
        ),
      ),
    );
  }

}