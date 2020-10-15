import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/item_page.dart';
import 'package:flutter_project/screens/order_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Home'),centerTitle:true,),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemPage()),
                    );
                  },
                  child: Text('Items'),),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderPage()),
                    );
                  },
                  child: Text('Orders'),),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemPage()),
                    );
                  },
                  child: Text('Items'),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
