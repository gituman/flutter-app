import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/model/user_model.dart';
import 'package:flutter_reg/screens/jim.dart';
import 'package:flutter_reg/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    jim(),
    Text("contact")
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Center(
      //     child:  
      //     Padding(
      //   padding: EdgeInsets.all(20),
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Text(
      //           "Welcome back",
      //           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Text(
      //           "${loggedInUser.firstname} ${loggedInUser.secondname}",
      //           style: TextStyle(
      //             color: Colors.black54,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         Text(
      //           "${loggedInUser.email}",
      //           style: TextStyle(
      //             color: Colors.black54,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         ActionChip(
      //             label: Text("Logout"),
      //             onPressed: () {
      //               logout(context);
      //             })
      //       ]),
      // )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'tournaments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_call),
            label: 'about',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
