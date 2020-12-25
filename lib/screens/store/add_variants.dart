import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';


class AddVariants extends StatefulWidget {
  final double width;
  AddVariants(this.width);
  @override
  _AddVariantsState createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {

  final List<Color> _colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
  ];

  // double _colorSliderPosition = 0;
  // double _shadeSliderPosition;
  // Color _currentColor;
  // Color _shadedColor;
  TextEditingController color_controller= TextEditingController();
  TextEditingController mrp_controller= TextEditingController();
  TextEditingController offer_controller= TextEditingController();
  TextEditingController discount_controller= TextEditingController();
  String final_price="";
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int r_value;
  int g_value;
  int b_value;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _currentColor = _calculateSelectedColor(_colorSliderPosition);
  //   _shadeSliderPosition = widget.width / 2; //center the shader selector
  //   _shadedColor = _calculateShadedColor(_shadeSliderPosition);
  // }

  // _colorChangeHandler(double position) {
  //   //handle out of bounds positions
  //   if (position > widget.width) {
  //     setState(() {
  //       position = widget.width;
  //     });
  //   }
  //   if (position < 0) {
  //     setState(() {
  //       position = 0;
  //     });
  //   }
  //   print("New pos: $position");
  //   setState(() {
  //     _colorSliderPosition = position;
  //     _currentColor = _calculateSelectedColor(_colorSliderPosition);
  //     _shadedColor = _calculateShadedColor(_shadeSliderPosition);
  //   });
  // }
  //
  // _shadeChangeHandler(double position) {
  //   //handle out of bounds gestures
  //   if (position > widget.width) {
  //     setState(() {
  //       position = widget.width;
  //     });
  //   };
  //   if (position < 0) {
  //
  //     setState(() {
  //       position = 0;
  //     });
  //   }
  //   setState(() {
  //     _shadeSliderPosition = position;
  //     _shadedColor = _calculateShadedColor(_shadeSliderPosition);
  //     if(_shadedColor.red==255 && _shadedColor.green==255 && _shadedColor.blue==255){
  //       setState(() {
  //         color_controller.text="white";
  //       });
  //     }else if(_shadedColor.red==0 && _shadedColor.green==0 && _shadedColor.blue==0){
  //       setState(() {
  //         color_controller.text="black";
  //       });
  //     }else if(_shadedColor.red == _shadedColor.green && _shadedColor.green==_shadedColor.blue && _shadedColor.red!=255 && _shadedColor.red!=0){
  //       setState(() {
  //         color_controller.text="grey";
  //       });
  //     }
  //     print(
  //         "r: ${_shadedColor.red}, g: ${_shadedColor.green}, b: ${_shadedColor.blue}");
  //   });
  // }
  //
  // Color _calculateShadedColor(double position) {
  //   double ratio = position / widget.width;
  //   if (ratio > 0.5) {
  //     //Calculate new color (values converge to 255 to make the color lighter)
  //     int redVal = _currentColor.red != 255
  //         ? (_currentColor.red +
  //         (255 - _currentColor.red) * (ratio - 0.5) / 0.5)
  //         .round()
  //         : 255;
  //     int greenVal = _currentColor.green != 255
  //         ? (_currentColor.green +
  //         (255 - _currentColor.green) * (ratio - 0.5) / 0.5)
  //         .round()
  //         : 255;
  //     int blueVal = _currentColor.blue != 255
  //         ? (_currentColor.blue +
  //         (255 - _currentColor.blue) * (ratio - 0.5) / 0.5)
  //         .round()
  //         : 255;
  //     return Color.fromARGB(255, redVal, greenVal, blueVal);
  //   } else if (ratio < 0.5) {
  //     //Calculate new color (values converge to 0 to make the color darker)
  //     int redVal = _currentColor.red != 0
  //         ? (_currentColor.red * ratio / 0.5).round()
  //         : 0;
  //     int greenVal = _currentColor.green != 0
  //         ? (_currentColor.green * ratio / 0.5).round()
  //         : 0;
  //     int blueVal = _currentColor.blue != 0
  //         ? (_currentColor.blue * ratio / 0.5).round()
  //         : 0;
  //     return Color.fromARGB(255, redVal, greenVal, blueVal);
  //   } else {
  //     //return the base color
  //     return _currentColor;
  //   }
  // }
  //
  // Color _calculateSelectedColor(double position) {
  //   //determine color
  //   double positionInColorArray =
  //   (position / widget.width * (_colors.length - 1));
  //   print(positionInColorArray);
  //   int index = positionInColorArray.truncate();
  //   int redValue;
  //   int greenValue;
  //   int blueValue;
  //   print(index);
  //   double remainder = positionInColorArray - index;
  //   if (remainder == 0.0) {
  //     _currentColor = _colors[index];
  //   } else {
  //     //calculate new color
  //     redValue = _colors[index].red == _colors[index + 1].red
  //         ? _colors[index].red
  //         : (_colors[index].red +
  //         (_colors[index + 1].red - _colors[index].red) * remainder)
  //         .round();
  //     greenValue = _colors[index].green == _colors[index + 1].green
  //         ? _colors[index].green
  //         : (_colors[index].green +
  //         (_colors[index + 1].green - _colors[index].green) * remainder)
  //         .round();
  //     blueValue = _colors[index].blue == _colors[index + 1].blue
  //         ? _colors[index].blue
  //         : (_colors[index].blue +
  //         (_colors[index + 1].blue - _colors[index].blue) * remainder)
  //         .round();
  //     _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
  //   }
  //   return _currentColor;
  // }

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Add Color', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purpleAccent,
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Size >> ', style: TextStyle(color: Colors.purpleAccent, fontSize: 17, fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddSize()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Color Name  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    new Container(
                      width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: color_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Select Color ', style: TextStyle(color: Colors.purpleAccent, fontSize: 17, fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.purpleAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: (){
                      _showdialog(context);
                    },
                  ),
                ),
                // Center(
                //   child: GestureDetector(
                //     behavior: HitTestBehavior.opaque,
                //     onHorizontalDragStart: (DragStartDetails details) {
                //       print("_-------------------------STARTED DRAG");
                //       _colorChangeHandler(details.localPosition.dx);
                //     },
                //     onHorizontalDragUpdate: (DragUpdateDetails details) {
                //       _colorChangeHandler(details.localPosition.dx);
                //     },
                //     onTapDown: (TapDownDetails details) {
                //       _colorChangeHandler(details.localPosition.dx);
                //     },
                //     //This outside padding makes it much easier to grab the   slider because the gesture detector has
                //     // the extra padding to recognize gestures inside of
                //     child: Container(
                //       width: widget.width,
                //       height: 18,
                //       decoration: BoxDecoration(
                //         border: Border.all(width: 2, color: Colors.grey[800]),
                //         borderRadius: BorderRadius.circular(15),
                //         gradient: LinearGradient(colors: _colors),
                //       ),
                //       child: CustomPaint(
                //         painter: _SliderIndicatorPainter(_colorSliderPosition),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 40,),
                // Center(
                //   child: GestureDetector(
                //     behavior: HitTestBehavior.opaque,
                //     onHorizontalDragStart: (DragStartDetails details) {
                //       print("_-------------------------STARTED DRAG");
                //       _shadeChangeHandler(details.localPosition.dx);
                //     },
                //     onHorizontalDragUpdate: (DragUpdateDetails details) {
                //       _shadeChangeHandler(details.localPosition.dx);
                //     },
                //     onTapDown: (TapDownDetails details) {
                //       _shadeChangeHandler(details.localPosition.dx);
                //     },
                //     //This outside padding makes it much easier to grab the slider because the gesture detector has
                //     // the extra padding to recognize gestures inside of
                //     child: Container(
                //       width: widget.width,
                //       height: 18,
                //       decoration: BoxDecoration(
                //         border: Border.all(width: 2, color: Colors.grey[800]),
                //         borderRadius: BorderRadius.circular(15),
                //         gradient: LinearGradient(
                //             colors: [Colors.black, _currentColor, Colors.white]),
                //       ),
                //       child: CustomPaint(
                //         painter: _SliderIndicatorPainter(_shadeSliderPosition),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('MRP ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    Text('₹', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(width: 10,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: mrp_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Offer ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: offer_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                            onChanged: (value){
                              setState(() {
                                double price= double.parse(mrp_controller.text);
                                double offer= double.parse(offer_controller.text);
                                final_price= (price- (price*(offer/100))).toString();
                                discount_controller.text=final_price;
                              });
                            },
                          ),
                        )
                    ),
                    SizedBox(width: 10,),
                    Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Discount ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    Text('₹', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(width: 10,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: discount_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10,bottom: 10),
                    textColor: Colors.white,
                    child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    color: Colors.green.shade500,
                    onPressed: (){
                      Navigator.pop(context);
                      Toast.show('loading...', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showdialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() {
                  currentColor = pickerColor;
                  r_value= currentColor.red;
                  g_value= currentColor.green;
                  b_value=currentColor.blue;
                  print(b_value);
                  color_controller.text=currentColor.toString();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }
}

// class _SliderIndicatorPainter extends CustomPainter {
//   final double position;
//   _SliderIndicatorPainter(this.position);
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawCircle(
//         Offset(position, size.height / 2), 15, Paint()..color = Colors.black);
//   }
//   @override
//   bool shouldRepaint(_SliderIndicatorPainter old) {
//     return true;
//   }
// }

class AddSize extends StatefulWidget {
  @override
  _AddSizeState createState() => _AddSizeState();
}

class _AddSizeState extends State<AddSize> {

  TextEditingController size_controller= TextEditingController();
  TextEditingController mrp_controller= TextEditingController();
  TextEditingController offer_controller= TextEditingController();
  TextEditingController discount_controller= TextEditingController();
  TextEditingController detail_controller= TextEditingController();
  String final_price="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Add Size', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purpleAccent,
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Color >> ', style: TextStyle(color: Colors.purpleAccent, fontSize: 17, fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddVariants(MediaQuery.of(context).size.width)));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Size Name  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: size_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Size Detail ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: detail_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('MRP ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    Text('₹', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(width: 10,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: mrp_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Offer ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: offer_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                            onChanged: (value){
                              setState(() {
                                double price= double.parse(mrp_controller.text);
                                double offer= double.parse(offer_controller.text);
                                final_price= (price- (price*(offer/100))).toString();
                                discount_controller.text=final_price;
                              });
                            },
                          ),
                        )
                    ),
                    SizedBox(width: 10,),
                    Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Discount ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(width: 30,),
                    Text('₹', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(width: 10,),
                    new Container(
                        width: 170,
                        color: Colors.grey, // or any color that matches your background
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: discount_controller,
                            decoration: InputDecoration.collapsed(hintText: "T"),
                            validator: (input) => input == "" ? 'The task is empty' : null,
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10,bottom: 10),
                    textColor: Colors.white,
                    child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    color: Colors.green.shade500,
                    onPressed: (){
                      Navigator.pop(context);
                      Toast.show('loading...', context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class AddVariants extends StatefulWidget {
//   @override
//   _AddVariantsState createState() => _AddVariantsState();
// }
//
// class _AddVariantsState extends State<AddVariants> {
//   String sizeVal = "Size";
//   List<String> sizeList = [
//     "Size 1",
//     "Size 2",
//     "Size 3",
//     "Size 4",
//     "Size 5"
//   ];
//
//   String colorVal = "Color";
//   List<String> colorList = [
//     "Colour 1",
//     "Colour 2",
//     "Colour 3",
//     "Colour 4",
//     "Colour 5"
//   ];
//
//   String offerVal = "Offer %";
//   List<String> offerList = [
//     "10%",
//     "20%",
//     "30%",
//     "40%",
//     "50%",
//     "60%",
//     "70%",
//     "80%",
//     "90%",
//     "100%"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(19, 110, 180, 1),
//         leading: InkWell(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//             child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
//         title: Text("Add Variants", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             height: MediaQuery.of(context).size.height*1.3,
//             padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
//             child: Column(
//               children: <Widget>[
//                 Card(
//                   elevation: 3.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
//                     height: 130.0,
//                     width: 350.0,
//                     child: Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           hint: Text(
//                             sizeVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                           ),
//                           items: sizeList.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value,),
//                             );
//                           }).toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               sizeVal = val;
//                             });
//                           },
//                         ),
//                         Container(
//                           height: 23.0,
//                           width: 85.0,
//                           padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey, width: 1.0),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0))
//                           ),
//                           child: Center(child: Text("Add Size", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Card(
//                   elevation: 3.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
//                     height: 130.0,
//                     width: 350.0,
//                     child: Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           hint: Text(
//                             colorVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                           ),
//                           items: colorList.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value,),
//                             );
//                           }).toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               colorVal = val;
//                             });
//                           },
//                         ),
//                         Container(
//                           height: 23.0,
//                           width: 85.0,
//                           padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey, width: 1.0),
//                               borderRadius: BorderRadius.all(Radius.circular(5.0))
//                           ),
//                           child: Center(child: Text("Add Colour", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                     child: Text("Price based on chosen Size and Colour :", style: TextStyle(fontSize: 16))),
//                 SizedBox(height: 20,),
//                 Card(
//                     elevation: 3.0,
//                     child: Container(
//                         padding: EdgeInsets.all(7),
//                         child: Text("Rs. 250/-", style:TextStyle(fontSize: 16)))),
//                 SizedBox(height: 20,),
//                 Card(
//                   elevation: 3.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
//                     height: 130.0,
//                     width: 350.0,
//                     child: Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           hint: Text(
//                             offerVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                           ),
//                           items: offerList.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value,),
//                             );
//                           }).toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               offerVal = val;
//                             });
//                           },
//                         ),
//                         Container(
//                           height: 23.0,
//                           width: 85.0,
//                           padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey, width: 1.0),
//                               borderRadius: BorderRadius.all(Radius.circular(5.0))
//                           ),
//                           child: Center(child: Text("Add Offer", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Price after offer is applied :", style: TextStyle(fontSize: 16))),
//                 SizedBox(height: 20,),
//                 Card(
//                   elevation: 3.0,
//                     child: Container(
//                       padding: EdgeInsets.all(7),
//                         child: Text("Rs. 250/-", style: TextStyle(fontSize: 16)))),
// //                SizedBox(height: 20,),
//                 SizedBox(height: 20,),
//                 Container(
//                   width: 280.0,
//                   height: 58.0,
//                   child: MaterialButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10))
//                     ),
//                     child: Text("Save & Continue", style: TextStyle(fontSize: 20),),
//                     textColor: Colors.white,
//                     padding: EdgeInsets.all(16),
//                     onPressed: () {
//                       addtoDatabase();
//                       Navigator.pop(context);
//                     },
//                     color: Color.fromRGBO(19, 110, 180, 1),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   addtoDatabase() async {
//     await FirebaseFirestore.instance.collection('products')
//     .doc('123456')
//         .set({
//       'size':sizeVal,
//       'color':colorVal,
//       'offer': offerVal.toString(),
//     }).then((value) {
//       print("success");
//     });
//   }
// }
