import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Order History"),
      ),
    );
  }
}
