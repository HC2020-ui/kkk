import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class RateApp extends StatefulWidget {
  @override
  _RateAppState createState() => _RateAppState();
}

class _RateAppState extends State<RateApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            color: Color.fromRGBO(93, 187, 99, 1),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('images/logo_app.png',
            height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20,),
          Text('Do you like Nukkd Store?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
          SizedBox(height: 7,),
          Text('If you enjoy it, please give us 5 Stars', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 20,),
          VxRating(
            selectionColor: Colors.yellow.shade500,
            maxRating: 5,
            onRatingUpdate: (value){
              print(value);
            },
            size: 50,
            value: 5,
            count: 5,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                child: Text('Rate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade600),),
                onPressed: (){
                  Toast.show('Feature Coming soon', context);
                },
              ),
              SizedBox(width: 10,),
              FlatButton(
                child: Text('Cancel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade600),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
