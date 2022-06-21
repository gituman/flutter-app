import 'package:flutter/material.dart';


class jim extends StatefulWidget {
  jim({Key? key}) : super(key: key);

  @override
  State<jim> createState() => _jimState();
}

class _jimState extends State<jim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      
    );
  }
}