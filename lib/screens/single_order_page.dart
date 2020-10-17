import 'package:flutter/material.dart';
import 'package:flutter_project/model/orders.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/sizeconfig.dart';

class SingleOrderPage extends StatelessWidget {
final int index;
final Orders orderItem;
   SingleOrderPage({Key key, this.index,this.orderItem}) : super(key: key);
    final _ctrlInquiry = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.safeBlockVertical;
    double width = SizeConfig.safeBlockHorizontal;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: height*20,
              color: Colors.grey[400],
              padding: EdgeInsets.all(width*5),
            child: Row(

              children: [
                Container(
                  padding: EdgeInsets.only(right: width*4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('id:'),
                      Text('${orderItem.orderId}'),
                      Icon(Icons.adjust)
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${orderItem.itemName}',style: TextStyle(fontSize: width*6),),
                      Text('${orderItem.price}'),

                    ],
                  ),
                )
              ],
            ),
            ),
            Container(
              width: double.infinity,
              height: height*50,
              color: Colors.grey[300],
              child:   Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(Icons.person,
                              size: 40.0, color: Colors.white),
                        ),
                        hintText: "Input your enquiry",
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(new Radius.circular(25.0))),
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                    controller: _ctrlInquiry,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty value";
                      }
                    },
                  ),
                  RaisedButton(onPressed: (){



                  },
                    child: Text('submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
