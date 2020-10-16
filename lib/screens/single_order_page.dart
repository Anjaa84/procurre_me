import 'package:flutter/material.dart';
import 'package:flutter_project/model/orders.dart';

class SingleOrderPage extends StatelessWidget {
final int index;
final Orders orderItem;
   SingleOrderPage({Key key, this.index,this.orderItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Text('${orderItem.orderId}'),
    );
  }
}
