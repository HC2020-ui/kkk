import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/add_variants.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String cat_val = "Choose Category";
  List<String> catlist = [
    'Choose Category',
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  String unit_val = "piece";
  List<String> unitsList = [
    "piece",
    "kg",
    "gm",
    "litre",
    "ml",
    "dozen"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 110, 180, 1),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
        title: Text("Add Product", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: KeyboardAvoider(
          autoScroll: true,
          child: Container(
            height: MediaQuery.of(context).size.height - 120.0,
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent.withOpacity(0.3))
                    ),
                    child: Icon(Icons.camera_alt, size: 38.0, color: Colors.grey,),
                  ),
                ),
                Spacer(flex: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                    child: Text("Add product images (upto 8)", style: TextStyle(color: Colors.grey.withOpacity(0.5)),)),
                Spacer(flex: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.orange, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: cat_val,
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: AppColors.orange,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            cat_val = newValue;
                          });
                        },
                        items: catlist.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 10,),
                Container(
                    child: TextFormField(
                      //validator: requireFieldValidator,

                      decoration: AppStyles.textFormFieldDecoration
                          .copyWith(hintText: 'Product Name'),
                    )),
             Spacer(flex: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          width: 150.0,
                          child: TextFormField(
                            //validator: requireFieldValidator,

                            decoration: AppStyles.textFormFieldDecoration
                                .copyWith(hintText: 'MRP'),
                          )),
                    ),
                    Flexible(
                      child: Container(
                          width: 150.0,
                          child: TextFormField(
                            //validator: requireFieldValidator,
                            decoration: AppStyles.textFormFieldDecoration
                                .copyWith(hintText: 'Selling Price'),
                          )),
                    ),
                  ],
                ),
                Spacer(flex: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          width: 150.0,
                          child: TextFormField(
                            //validator: requireFieldValidator,
                            decoration: AppStyles.textFormFieldDecoration
                                .copyWith(hintText: 'per 1 piece'),
                          )),
                    ),
                    Flexible(
                      child: Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.orange, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: unit_val,
                              isExpanded: true,
                              underline: Container(
                                height: 2,
                                color: AppColors.orange,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  unit_val = newValue;
                                });
                              },
                              items: unitsList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 10,),
                Container(
                    child: TextFormField(
                      //validator: requireFieldValidator,
                      decoration: AppStyles.textFormFieldDecoration
                          .copyWith(hintText: 'Product Details(Optional)'),
                    )),
                Spacer(flex: 30,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddVariants()),
                    );
                  },
                    child: Align(
                      alignment: Alignment.centerLeft,
                        child: Text("ADD SIZE/COLOR", style: TextStyle(fontSize: 18.0, color:  Color.fromRGBO(19, 110, 180, 1), fontWeight: FontWeight.w600),))),
                Spacer(flex: 50,),
                Container(
                  width: double.infinity,
                  height: 58.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text("Add Product"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      ////////////
                    },
                    color: Color.fromRGBO(19, 110, 180, 1),
                  ),
                ),
                Spacer(flex: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
