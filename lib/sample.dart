
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sample extends StatefulWidget{
  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
    );
  }
}