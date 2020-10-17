import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/admin_page.dart';
import 'package:flutter_project/screens/item_page.dart';
import 'package:flutter_project/screens/order_page.dart';
import 'package:flutter_project/screens/supervisor_page.dart';
import 'package:flutter_project/screens/supplier_page.dart';
import 'package:flutter_project/utils/sizeconfig.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.safeBlockVertical;
    double width = SizeConfig.safeBlockHorizontal;

    //cutomized common button to navigate to pages
    _navigationButton(){
      return   _customNavigationButton(width, context);
    };


    return Scaffold(
      appBar: AppBar(title:Text('Home'),centerTitle:true,),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
          child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customNavigationButton(width, context),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderPage()),
                    );
                  },
                  child: Text('Orders'),),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  },
                  child: Text('Admin'),),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SupplierPage()),
                    );
                  },
                  child: Text('Supplier'),),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SupervisorPage()),
                    );
                  },
                  child: Text('Supervisor'),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton _customNavigationButton(double width, BuildContext context) {
    return RaisedButton(
                elevation:width*10,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPage()),
                  );
                },
                child: Text('Items'),);
  }
}
