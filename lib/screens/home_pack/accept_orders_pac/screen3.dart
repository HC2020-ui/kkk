import 'package:flutter/material.dart';
import '../../../appBar.dart';

double iconSize = 20;

class ThirdScreen extends StatelessWidget {
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
              Container(
                margin: EdgeInsets.all(30),
                child: Text('Address'),
              ),
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
              SingleChildScrollView(
                child: Row(
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        color: Colors.grey,
                        onPressed: () {},
                        child: Text('Assign Deliveryman'),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text('Delivery Man'),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
              ),
              buttons('Delivered ', Colors.indigoAccent),
//              buttons('Picked by Customer', Colors.cyan),
              buttons('Cancel Order', Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buttonMaker({int num, Color color, String text}) {
    return Expanded(
      child: FlatButton(
        child: Text(text),
        color: color,
        onPressed: () {},
      ),
    );
  }

  Center buttons(String text, Color color) {
    return Center(
      heightFactor: 1.5,
      child: SizedBox(
        width: 200,
        height: 50,
        child: RaisedButton(
          elevation: 5,
          color: color,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}
