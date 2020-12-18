import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winkl/screens/store/brands/service_list.dart';

import 'accept_orders_pac/accept_orders.dart';
import 'manage_employees/employee_list.dart';
import 'manage_inventory/productsList.dart';
import 'manage_orders_pac/manage_orders_home.dart';

class NewHomePage extends StatefulWidget {
  String store_type;
  String phone_number;
  String uid;
  NewHomePage({this.store_type,this.phone_number,this.uid});
  @override
  _NewHomePageState createState() => _NewHomePageState();
}


class _NewHomePageState extends State<NewHomePage> {


  int _cIndex = 0;
  String vendor_type;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  final List<Widget> _children=[
    AcceptOrders(),
    ManageOrdersHome(),
    ProductList(),
    EmployeeList(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vendor_type=widget.store_type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_cIndex],
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Color.fromRGBO(93, 187, 99, 1),
        textColor: Colors.black,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.black,
        tabs: [
          TabData(
            iconData: Icons.shopping_basket,
            title: "Accepted Orders",
          ),
          TabData(
            iconData: Icons.playlist_add,
            title: "Manage Orders",
          ),
          TabData(
            iconData: Icons.pending_sharp,
            title: "Product List",
          ),
          TabData(
            iconData: Icons.person_add_alt_1,
            title: "Manage Staff",
          ),
        ],
        onTabChangedListener: (position){
          setState(() {
            _cIndex=position;
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   fixedColor: Colors.black,
      //   currentIndex: _cIndex,
      //   type: BottomNavigationBarType.shifting ,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Tab(
      //           icon: Container(
      //             child: Image(
      //               image: AssetImage(
      //                 'images/accepted.png',
      //               ),
      //               fit: BoxFit.cover,
      //             ),
      //             height: 30,
      //             width: 30,
      //           ),
      //         ),
      //         label: 'Accepted Orders'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Tab(
      //           icon: Container(
      //             child: Image(
      //               image: AssetImage(
      //                 'images/manage_orders.png',
      //               ),
      //               fit: BoxFit.cover,
      //             ),
      //             height: 30,
      //             width: 30,
      //           ),
      //         ),
      //         label: 'Manage Orders'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Tab(
      //           icon: Container(
      //             child: Image(
      //               image: AssetImage(
      //                 'images/manage_inventory.png',
      //               ),
      //               fit: BoxFit.cover,
      //             ),
      //             height: 30,
      //             width: 30,
      //           ),
      //         ),
      //         label:widget.store_type.toLowerCase()=='services' ?'Manage Services':'Manage Products'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Tab(
      //           icon: Container(
      //             child: Image(
      //               image: AssetImage(
      //                 'images/manage_staff.png',
      //               ),
      //               fit: BoxFit.cover,
      //             ),
      //             height: 30,
      //             width: 30,
      //           ),
      //         ),
      //         label: 'Manage Staff'
      //     )
      //   ],
      //   onTap: (index){
      //     _incrementTab(index);
      //   },
      // ),
    );
  }
}
